import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ahueni/models/user_journal.dart';

class UserJournalService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add a new journal entry for the current user
  Future<void> addUserJournal(UserJournal journal) async {
    final user = _auth.currentUser;
    if (user != null) {
      journal = UserJournal(
        journalId: journal.journalId,
        userId: user.uid, // Associate the journal with the current user
        title: journal.title,
        body: journal.body,
        createdAt: journal.createdAt,
      );

      await _db.collection('Users').doc(user.uid).collection('Journals').doc(journal.journalId).set(journal.toMap());
    }
  }

  // Update an existing journal entry for the current user
  Future<void> updateUserJournal(UserJournal journal) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _db.collection('Users').doc(user.uid).collection('Journals').doc(journal.journalId).update(journal.toMap());
    }
  }

  // Delete a journal entry for the current user
  Future<void> deleteUserJournal(String journalId) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _db.collection('Users').doc(user.uid).collection('Journals').doc(journalId).delete();
    }
  }

  // Get all journal entries for the current user
  Future<List<UserJournal>> getUserJournals() async {
    final user = _auth.currentUser;
    if (user != null) {
      final snapshot = await _db.collection('Users').doc(user.uid).collection('Journals').get();
      return snapshot.docs.map((doc) => UserJournal.fromMap(doc.data())).toList();
    } else {
      return []; // Return an empty list if no user is logged in
    }
  }

  // Stream journal entries for the current user
  Stream<List<UserJournal>> streamUserJournals() {
    final user = _auth.currentUser;
    if (user != null) {
      return _db
          .collection('Users')
          .doc(user.uid)
          .collection('Journals')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => UserJournal.fromMap(doc.data()))
              .toList());
    } else {
      return const Stream.empty(); // Return an empty stream if no user is logged in
    }
  }
}
