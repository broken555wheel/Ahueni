import 'package:ahueni/models/user_tasks.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserTaskService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fetch user tasks from Firestore
  Future<List<UserTask>> getUserTasks() async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw Exception("User not logged in");
    }

    QuerySnapshot snapshot = await _db
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .get();

    return snapshot.docs.map((doc) => UserTask.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  // Add a new task to Firestore
  Future<void> addUserTask(UserTask task) async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw Exception("User not logged in");
    }

    await _db
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(task.taskId)
        .set(task.toMap());
  }

  // Update an existing task in Firestore
  Future<void> updateUserTask(UserTask task) async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw Exception("User not logged in");
    }

    await _db
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(task.taskId)
        .update(task.toMap());
  }

  // Delete a task from Firestore
  Future<void> deleteUserTask(String taskId) async {
    final userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw Exception("User not logged in");
    }

    await _db
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }
}
