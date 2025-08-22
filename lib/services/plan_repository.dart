import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/plan_model.dart';

class PlanRepository {
  CollectionReference? _colOrNull() {
    try {
      return FirebaseFirestore.instance.collection('plans');
    } catch (_) {
      return null;
    }
  }

  Stream<List<PlanModel>> streamAll() {
    final col = _colOrNull();
    if (col == null) return Stream.value(<PlanModel>[]);
    return col.snapshots().map((snap) => snap.docs.map((d) => PlanModel.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());
  }

  // If Firestore collection is empty, provide a list of example plans so UI can show demo data.
  Stream<List<PlanModel>> streamAllWithFallback() {
    final sample = [
      PlanModel(id: 'basic', name: 'Básico', description: 'Banner por 7 días en sección secundaria', pricePerMonth: 50.0, durationDays: 7),
      PlanModel(id: 'standard', name: 'Estándar', description: 'Banner por 14 días en zona principal', pricePerMonth: 120.0, durationDays: 14),
      PlanModel(id: 'premium', name: 'Premium', description: 'Banner destacado por 30 días en la parte superior (móvil)', pricePerMonth: 250.0, durationDays: 30),
    ];
    final col = _colOrNull();
    if (col == null) return Stream.value(sample);
    return col.snapshots().map((snap) {
      final list = snap.docs.map((d) => PlanModel.fromMap(d.id, d.data() as Map<String, dynamic>)).toList();
      return list.isEmpty ? sample : list;
    });
  }
  Future<String> add(PlanModel p) async {
    final col = _colOrNull();
    if (col == null) throw StateError('Firebase not available');
    final doc = await col.add(p.toMap());
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
