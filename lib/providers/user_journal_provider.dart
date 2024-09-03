import 'package:flutter/material.dart';
import 'package:ahueni/models/user_journal.dart';
import 'package:ahueni/services/journal/user_journal_service.dart';

class UserJournalProvider with ChangeNotifier {
  final UserJournalService _userJournalService = UserJournalService();
  List<UserJournal> _journals = [];

  List<UserJournal> get journals => _journals;

  // Fetch journals for the current user
  Future<void> fetchJournals() async {
    _journals = await _userJournalService.getUserJournals();
    notifyListeners();
  }

  // Add a new journal
  Future<void> addJournal(UserJournal journal) async {
    await _userJournalService.addUserJournal(journal);
    _journals.add(journal);
    notifyListeners();
  }

  // Update an existing journal
  Future<void> updateJournal(UserJournal journal) async {
    await _userJournalService.updateUserJournal(journal);
    final index = _journals.indexWhere((j) => j.journalId == journal.journalId);
    if (index != -1) {
      _journals[index] = journal;
      notifyListeners();
    }
  }

  // Delete a journal
  Future<void> deleteJournal(String journalId) async {
    await _userJournalService.deleteUserJournal(journalId);
    _journals.removeWhere((j) => j.journalId == journalId);
    notifyListeners();
  }

  // Stream journals for real-time updates
  Stream<List<UserJournal>> streamJournals() {
    return _userJournalService.streamUserJournals();
  }
}
