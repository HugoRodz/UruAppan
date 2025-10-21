import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/oficio.dart';

class OficioRepository {
  final CollectionReference _col = FirebaseFirestore.instance.collection('oficios');

  Stream<List<Oficio>> streamAll() {
    return _col.snapshots().map((snap) => snap.docs.map((d) => Oficio.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());
  }

  Future<String> add(Oficio oficio) async {
    final doc = await _col.add(oficio.toMap());
    return doc.id;
  }

  Future<Oficio?> getById(String id) async {
    final d = await _col.doc(id).get();
    if (!d.exists) return null;
    return Oficio.fromMap(d.id, d.data() as Map<String, dynamic>);
  }

  Future<void> updatePublication(String id, bool publicado) async {
    await _col.doc(id).update({'publicado': publicado});
  }

  Future<void> delete(String id) async {
    await _col.doc(id).delete();
  }
}
