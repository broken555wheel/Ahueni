import 'package:ahueni/models/user_sobriety.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserSobrietyService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fetch user sobriety data from Firestore
  Future<UserSobriety?> getUserSobrietyData() async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw Exception("User not logged in");
    }

    DocumentSnapshot snapshot = await _db.collection('users').doc(userId).get();
    if (snapshot.exists) {
      return UserSobriety.fromMap(snapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  // Update user sobriety data in Firestore
  Future<void> updateUserSobrietyData(UserSobriety sobriety) async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw Exception("User not logged in");
    }

    await _db.collection('users').doc(userId).set(sobriety.toMap(), SetOptions(merge: true));
  }

  // Add other methods if necessary, like deleting or resetting sobriety data
}
