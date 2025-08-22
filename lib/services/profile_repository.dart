import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepository {
  CollectionReference<Map<String, dynamic>>? _usersCol() {
    try {
      return FirebaseFirestore.instance.collection('users').withConverter<Map<String, dynamic>>(
        fromFirestore: (snap, _) => snap.data() ?? {},
        toFirestore: (m, _) => m,
      );
    } catch (e) {
      // Firebase not initialized or other error; return null to indicate unavailable
      return null;
    }
  }

  Future<bool> saveProfileForUser(String uid, String profile) async {
    final col = _usersCol();
    if (col == null) return false;
    try {
      await col.doc(uid).set({'profile': profile}, SetOptions(merge: true));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getProfileForUser(String uid) async {
    final col = _usersCol();
    if (col == null) return null;
    try {
      final snap = await col.doc(uid).get();
      final data = snap.data();
      if (data == null) return null;
      return data['profile'] as String?;
    } catch (e) {
      return null;
    }
  }
}
