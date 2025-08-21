import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/anuncio.dart';

class AnuncioRepository {
  final CollectionReference _col = FirebaseFirestore.instance.collection('anuncios');

  Stream<List<Anuncio>> streamAll() {
    return _col.orderBy('createdAt', descending: true).snapshots().map((snap) => snap.docs.map((d) => Anuncio.fromMap(d.id, d.data() as Map<String, dynamic>)).toList());
  }

  Future<String> add(Anuncio a) async {
    final doc = await _col.add(a.toMap());
    return doc.id;
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    await _col.doc(id).update(data);
  }

  Future<void> delete(String id) async {
    await _col.doc(id).delete();
  }
}
