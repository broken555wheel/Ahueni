import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  // get instance of firestore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //  get user stream
Stream<List<Map<String, dynamic>>> getUserStream() {
  return _fireStore.collection("Users").snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      final user = doc.data();
      return user;
    }).toList();
  });
}
  // send message

  // receive message
}
