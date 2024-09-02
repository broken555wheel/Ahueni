import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ahueni/models/user_profile.dart';

class UserProfileService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Fetch the user profile from Firestore
  Future<UserProfile?> getUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc = await _db.collection('users').doc(user.uid).get();
    if (doc.exists) {
      return UserProfile.fromMap(doc.data()!);
    }
    return null;
  }

  // Update the user profile in Firestore
  Future<void> updateUserProfile(UserProfile profile) async {
    await _db.collection('users').doc(profile.uid).set(profile.toMap());
  }

  // Upload the profile image to Firebase Storage and update the UserProfile
  Future<void> uploadProfileImage(String uid, XFile imageFile) async {
    try {
      // Upload the image to Firebase Storage
      final storageRef = _storage.ref().child('userProfileImages/$uid.jpg');
      await storageRef.putFile(File(imageFile.path));

      // Get the download URL of the uploaded image
      final downloadUrl = await storageRef.getDownloadURL();

      // Update the user's profile with the new image URL
      await _db
          .collection('users')
          .doc(uid)
          .update({'profileImageUrl': downloadUrl});
    } catch (e) {
      print('Failed to upload profile image: $e');
      rethrow;
    }
  }
}
