import 'package:flutter/material.dart';
import 'package:flutter_back_golang/models/chat_message.dart';
import 'package:flutter_back_golang/widgets/message_bubble.dart';

class MessageList extends StatelessWidget {
  MessageList({super.key});

  final messages = [
    ChatMessage(
      roomId: '1',
      message: 'これはテストです。',
      sender: Sender.bot.toString(),
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      roomId: '1',
      message: 'こんにちは！',
      sender: Sender.bot.toString(),
      createdAt: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        image: DecorationImage(
          opacity: 0.1,
          image: AssetImage('assets/images/supabase.png'),
        ),
      ),
      child: ListView(
        children: [
          for (final message in messages) MessageBubble(message: message),
        ],
      ),
    );
  }
}
