import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/banner_model.dart';

class BannerRepository {
  // Do not access FirebaseFirestore.instance at top-level (tests may not initialize Firebase).

  CollectionReference? _colOrNull() {
    try {
      return FirebaseFirestore.instance.collection('banners');
    } catch (_) {
      return null;
    }
  }

  Stream<List<BannerModel>> streamAll() {
    final col = _colOrNull();
    if (col == null) return Stream.value(<BannerModel>[]);
    return col.snapshots().map((snap) => snap.docs.map((d) => BannerModel.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());
  }

  // If Firestore has no banners, provide sample banners so UI can preview immediately.
  Stream<List<BannerModel>> streamAllWithFallback() {
    final sample = [
      BannerModel(id: 's1', title: 'Promoción: Taller de Carpintería', imageUrl: 'https://picsum.photos/seed/carpinteria/800/300', targetUrl: '', premium: true, planId: 'premium', planName: 'Premium'),
      BannerModel(id: 's2', title: 'Descuento en Servicios de Jardinería', imageUrl: 'https://picsum.photos/seed/jardineria/800/300', targetUrl: '', premium: false),
      BannerModel(id: 's3', title: 'Reparación de Electrodomésticos - 20% off', imageUrl: 'https://picsum.photos/seed/electro/800/300', targetUrl: '', premium: true, planId: 'standard', planName: 'Estándar'),
    ];
    final col = _colOrNull();
    if (col == null) return Stream.value(sample);
    return col.snapshots().map((snap) {
      final list = snap.docs.map((d) => BannerModel.fromMap(d.id, d.data() as Map<String, dynamic>)).toList();
      return list.isEmpty ? sample : list;
    });
  }

  Future<String> add(BannerModel b) async {
    final col = _colOrNull();
    if (col == null) throw StateError('Firebase not available');
    final doc = await col.add(b.toMap());
    return doc.id;
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    final col = _colOrNull();
    if (col == null) throw StateError('Firebase not available');
    await col.doc(id).update(data);
  }

  Future<void> delete(String id) async {
    final col = _colOrNull();
    if (col == null) throw StateError('Firebase not available');
    await col.doc(id).delete();
  }
}
