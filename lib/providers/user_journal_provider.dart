import 'package:ahueni/services/journal/user_journal_service.dart';
import 'package:flutter/material.dart';
import 'package:ahueni/models/user_journal.dart';

class UserJournalProvider with ChangeNotifier {
  final UserJournalService _userJournalService = UserJournalService();
  List<UserJournal> _journals = [];

  List<UserJournal> get journals => _journals;

  Future<void> fetchJournals(String userId) async {
    _journals = await _userJournalService.getUserJournals(userId);
    notifyListeners();
  }

  Future<void> addJournal(UserJournal journal) async {
    await _userJournalService.addUserJournal(journal);
    _journals.add(journal);
    notifyListeners();
  }

  Future<void> updateJournal(UserJournal journal) async {
    await _userJournalService.updateUserJournal(journal);
    final index = _journals.indexWhere((j) => j.journalId == journal.journalId);
    if (index != -1) {
      _journals[index] = journal;
      notifyListeners();
    }
  }

  Future<void> deleteJournal(String journalId) async {
    await _userJournalService.deleteUserJournal(journalId);
    _journals.removeWhere((j) => j.journalId == journalId);
    notifyListeners();
  }
}
