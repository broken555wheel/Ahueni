import 'package:ahueni/services/profile/user_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:ahueni/models/user_profile.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileProvider with ChangeNotifier {
  UserProfile? _userProfile;
  final UserProfileService _userProfileService = UserProfileService();

  UserProfile? get userProfile => _userProfile;

  Future<void> fetchUserProfile() async {
    _userProfile = await _userProfileService.getUserProfile();
    notifyListeners();
  }

  Future<void> updateProfile(UserProfile updatedProfile) async {
    _userProfile = updatedProfile;
    await _userProfileService.updateUserProfile(updatedProfile);
    notifyListeners();
  }

  Future<void> updateProfileImage(XFile imageFile) async {
    if (_userProfile != null) {
      await _userProfileService.uploadProfileImage(_userProfile!.uid, imageFile);
      await fetchUserProfile();
    }
  }
}
