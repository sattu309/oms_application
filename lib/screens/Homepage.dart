import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oms_app/resuources/constants.dart';

class ChatScreen extends StatefulWidget {
  final String receiverEmail;

  ChatScreen({required this.receiverEmail});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final  _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();

  String getChatId(String user1, String user2) {
    return user1.compareTo(user2) < 0 ? '$user1 $user2' : '$user2 $user1';
  }

  void sendMessage(String text) async {
    if (text.isEmpty) return;

    final senderEmail = _auth.currentUser?.email ?? 'Anonymous';
    final chatId = getChatId(senderEmail, widget.receiverEmail);

    await _firestore.collection('chats').doc(chatId).collection('messages').add({
      'text': text,
      'sender': senderEmail,
      'receiver': widget.receiverEmail,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
  }

  Stream<List<Map<String, dynamic>>> getMessages(String chatId){
    return _firestore
        .collection('chats').doc(chatId).collection('messages').orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList());
  }

  @override
  Widget build(BuildContext context) {
    final senderEmail = _auth.currentUser?.email ?? 'Anonymous';
    final chatId = getChatId(senderEmail, widget.receiverEmail);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppTextColor.primaryColor,
          title: Text("Chat ${widget.receiverEmail}",style: Theme.of(context).textTheme.titleSmall)),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: getMessages(chatId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final messages = snapshot.data!;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    var  dateTime1 = message['timestamp'].toDate();
                    final dateTime = DateFormat('hh:mm a').format(dateTime1);
                    final isMe = message['sender'] == senderEmail;
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${message['text']} $dateTime",
                          style: TextStyle(color: isMe ? Colors.white : Colors.black),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(.0,.3)
                  )
                ]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration:  InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:  BorderSide(color: Colors.grey.shade300,width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder:  OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                              borderRadius: const BorderRadius.all(Radius.circular(20))),
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey.shade300, width: 3.0),
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "Type a message..",

                        contentPadding: EdgeInsets.symmetric(horizontal: 10,)
                      ),

                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => sendMessage(_messageController.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
