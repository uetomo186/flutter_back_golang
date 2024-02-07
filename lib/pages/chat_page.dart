import 'package:flutter/material.dart';
import 'package:flutter_back_golang/models/chat_room.dart';
import 'package:flutter_back_golang/widgets/app_drawer.dart';
import 'package:flutter_back_golang/widgets/message_list.dart';
import 'package:flutter_back_golang/widgets/message_text_field.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chat Page'),
        ),
        drawer: const AppDrawer(),
        body: Column(
          children: [
            Expanded(
              child: MessageList(),
            ),
            const MessageTextField(),
          ],
        ));
  }

  Future<ChatRoom?> createChatRoom(
    BuildContext context, {
    required String roomName,
    required String userId,
  }) async {
    try {
      final result = await Supabase.instance.client.from('chat_rooms').insert({
        'room_name': roomName,
        'user_id': userId,
      }).select();
      return ChatRoom.fromJson(result.first);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }

  Future<void> sendChatMessage(
    BuildContext context, {
    required String roomId,
    required String message,
    required bool fromBot,
  }) async {
    try {
      await Supabase.instance.client.from('chat_messages').insert({
        'room_id': roomId,
        'message': message,
        'sent_by_bot': fromBot,
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }
}
