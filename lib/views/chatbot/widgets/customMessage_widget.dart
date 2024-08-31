import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class CustomMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final ChatUser currentUser;

  const CustomMessageBubble({
    Key? key,
    required this.message,
    required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = message.user.id == currentUser.id;

    return Row(
      mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isCurrentUser) 
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/sugabot.png'),
          ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message.text,
            style: TextStyle(
              color: isCurrentUser ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
