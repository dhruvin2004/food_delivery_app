import 'package:flutter/material.dart';


class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        buildMessage(
          isMe: false,
          senderName: 'John Doe',
          messageText: 'Hello',
        ),
        buildMessage(
          isMe: true,
          senderName: 'You',
          messageText: 'Hi',
        ),
        buildMessage(
          isMe: false,
          senderName: 'John Doe',
          messageText: 'How are you?',
        ),
      ],
    );
  }
}

Widget buildMessage({
  required bool isMe,
  required String senderName,
  required String messageText,
}) {
  return ListTile(
    leading: CircleAvatar(
      child: Text(senderName[0]),
    ),
    title: Text(
      senderName,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    subtitle: Text(messageText),
    trailing: isMe ? Icon(Icons.check) : null,
  );
}

