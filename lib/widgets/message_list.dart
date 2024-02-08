import 'package:flutter/material.dart';
import 'package:flutter_back_golang/models/chat_message.dart';
import 'package:flutter_back_golang/widgets/message_bubble.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MessageList extends StatelessWidget {
  MessageList({super.key, required this.roomId});

  final String roomId;

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
      child: StreamBuilder(
          stream: getMessageStream(roomId),
          builder: (context, AsyncSnapshot snapshot) {
            return ListView(
              children: [
                for (final message in messages) MessageBubble(message: message),
              ],
            );
          }),
    );
  }

  Stream<List<ChatMessage>> getMessageStream(String? roomId) {
    if (roomId == null) return const Stream.empty();

    return Supabase.instance.client
        .from('chat_masseges')
        .stream(primaryKey: ['message_id'])
        .eq('room_id', roomId)
        .order('created_at')
        .map((snapshot) {
          return snapshot.map(ChatMessage.fromJson).toList();
        });
  }
}
