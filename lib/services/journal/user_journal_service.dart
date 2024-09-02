import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ahueni/models/user_journal.dart';

class UserJournalService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUserJournal(UserJournal journal) async {
    await _db.collection('journals').doc(journal.journalId).set(journal.toMap());
  }

  Future<void> updateUserJournal(UserJournal journal) async {
    await _db.collection('journals').doc(journal.journalId).update(journal.toMap());
  }

  Future<void> deleteUserJournal(String journalId) async {
    await _db.collection('journals').doc(journalId).delete();
  }

  Future<List<UserJournal>> getUserJournals(String userId) async {
    final snapshot = await _db
        .collection('journals')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs
        .map((doc) => UserJournal.fromMap(doc.data()))
        .toList();
  }
}
