import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/models/chat/firestore_message.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';

class ChatItem extends StatelessWidget {
  final FirestoreMessage data;
  const ChatItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    final bool isSender = data.sentBy == authProvider.user.id;
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (isSender ? Alignment.topRight : Alignment.topLeft),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (isSender ? Colors.blue[200] : Colors.grey.shade200),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            data.messageText,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
