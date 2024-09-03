import 'package:ahueni/models/user_sobriety.dart';
import 'package:ahueni/services/sobriety/user_sobriety_service.dart';
import 'package:flutter/material.dart';

class UserSobrietyProvider with ChangeNotifier {
  final UserSobrietyService _userSobrietyService = UserSobrietyService();
  UserSobriety? _userSobriety;
  bool isNewUser = false;  // Flag to indicate if the user is new

  UserSobriety? get userSobriety => _userSobriety;

  // Fetch sobriety data for the current user
  Future<void> fetchSobrietyData() async {
    try {
      final sobrietyData = await _userSobrietyService.getUserSobrietyData();
      if (sobrietyData == null) {
        isNewUser = true; // No data found, the user is considered new
      } else {
        _userSobriety = sobrietyData;
        isNewUser = false; // Data found, the user is not new
      }
      notifyListeners();
    } catch (e) {
      print("Failed to fetch sobriety data: $e");
    }
  }

  // Update sobriety data
  Future<void> updateSobrietyData(UserSobriety sobriety) async {
    try {
      await _userSobrietyService.updateUserSobrietyData(sobriety);
      _userSobriety = sobriety;
      isNewUser = false; // After updating data, the user is no longer new
      notifyListeners();
    } catch (e) {
      print("Failed to update sobriety data: $e");
    }
  }

  // Update the addiction field
  Future<void> updateAddiction(String newAddiction) async {
    if (_userSobriety != null) {
      _userSobriety = UserSobriety(
        startDate: _userSobriety!.startDate,
        endDate: _userSobriety!.endDate,
        currentStreak: _userSobriety!.currentStreak,
        longestStreak: _userSobriety!.longestStreak,
        addiction: newAddiction,
      );
      await updateSobrietyData(_userSobriety!);
    }
  }

  // Reset sobriety data
  Future<void> resetSobrietyData(DateTime newStartDate) async {
    try {
      if (_userSobriety != null) {
        _userSobriety = UserSobriety(
          startDate: newStartDate,
          currentStreak: 0,
          longestStreak: _userSobriety!.longestStreak,
          addiction: _userSobriety!.addiction, // Keep the current addiction
        );
        await updateSobrietyData(_userSobriety!);
      }
    } catch (e) {
      print("Failed to reset sobriety data: $e");
    }
  }
}
