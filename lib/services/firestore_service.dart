import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference collection(String path) => _db.collection(path);

  // Example: save map to collection
  Future<DocumentReference> add(String path, Map<String, dynamic> data) {
    return collection(path).add(data);
  }

  Future<void> set(String path, String id, Map<String, dynamic> data) {
    return collection(path).doc(id).set(data);
  }

  Stream<QuerySnapshot> streamCollection(String path) {
    return collection(path).snapshots();
  }
}
