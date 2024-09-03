import 'package:ahueni/components/my_app_bar.dart';
import 'package:ahueni/components/my_chat_bubble.dart';
import 'package:ahueni/components/my_text_field.dart';
import 'package:ahueni/services/auth/auth_service.dart';
import 'package:ahueni/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({required this.receiverEmail, required this.receiverID, super.key});

  final TextEditingController _messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, _messageController.text);

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: receiverEmail),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;

    return StreamBuilder(
        stream: _chatService.getMessages(receiverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container( alignment:alignment, child: MyChatBubble(message: data['message'], isCurrentUser: isCurrentUser, messageId: doc.id, userId: data['senderID'],) );
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 10, right: 5),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
                hintText: 'Type a message',
                controller: _messageController,
                obscureText: false),
          ),
          const SizedBox(width: 10),
          Container(decoration:const BoxDecoration(
            color:  Color.fromARGB(255, 232, 94, 86),
            shape: BoxShape.circle,
          ),margin: const EdgeInsets.only(right: 15,) ,child: IconButton(onPressed: sendMessage, icon: const Icon(Icons.arrow_upward),),),
        ],
      ),
    );
  }
}
