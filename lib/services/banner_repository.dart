import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/banner_model.dart';

class BannerRepository {
  final CollectionReference _col = FirebaseFirestore.instance.collection('banners');

  Stream<List<BannerModel>> streamAll() {
    return _col.snapshots().map((snap) => snap.docs.map((d) => BannerModel.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());
  }

  Future<String> add(BannerModel b) async {
    final doc = await _col.add(b.toMap());
    return doc.id;
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _col.doc(id).update(data);
  }

  Future<void> delete(String id) async {
    await _col.doc(id).delete();
  }
}
