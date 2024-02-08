import 'package:flutter/material.dart';
import 'package:flutter_back_golang/models/chat_message.dart';
import 'package:flutter_back_golang/models/chat_room.dart';
import 'package:flutter_back_golang/widgets/app_drawer.dart';
import 'package:flutter_back_golang/widgets/message_list.dart';
import 'package:flutter_back_golang/widgets/message_text_field.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    this.room,
  });

  final ChatRoom? room;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late String userId;
  late ChatRoom room;

  @override
  void initState() {
    userId = Supabase.instance.client.auth.currentUser!.id;
    room = widget.room ??
        ChatRoom(userId: userId, name: 'New chat', createdAt: DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(room.name),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await deleteChatRoom(context, roomId: room.id!);
              if (result != null && context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ChatPage(),
                  ),
                );
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Expanded(
            child: MessageList(
              roomId: room.id,
            ),
          ),
          MessageTextField(
            onSubmitted: (message) async {
              // チャットルームがなければ作成
              if (room.id == null) {
                final result = await createChatRoom(context,
                    userId: room.userId, roomName: room.name);
                // チャットルームが作成できたら、roomに代入
                if (result != null) {
                  setState(() {
                    room = result;
                  });
                }
              }

              // メッセージテーブルにレコードを挿入
              if (context.mounted)
                await sendChatMessage(context,
                    message: message, room: room, fromBot: false);

              // メッセージ履歴を取得する
              List<ChatMessage> messages = [];
              if (context.mounted) {
                messages = await retrieveMessages(context, room: room);
              }
              // ボットからのメッセージを受け取る
              if (context.mounted && message.isNotEmpty)
                await receiveBotMessage(context,
                    room: room, chatHistories: messages);
            },
          ),
        ],
      ),
    );
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
    required String message,
    required ChatRoom room,
    required bool fromBot,
  }) async {
    try {
      await Supabase.instance.client.from('chat_messages').insert({
        'room_id': room.id,
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
    }
    return;
  }

  Future<ChatRoom?> deleteChatRoom(
    BuildContext context, {
    required String roomId,
  }) async {
    try {
      final result = await Supabase.instance.client
          .from('chat_rooms')
          .delete()
          .eq('room_id', roomId)
          .select();
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

  Future<List<ChatMessage>> retrieveMessages(
    BuildContext context, {
    required ChatRoom room,
  }) async {
    try {
      final result = await Supabase.instance.client
          .from('chat_messages')
          .select()
          .eq(
            'room_id',
            room.id!,
          )
          .order(
            'created_at',
          )
          .limit(10);
      return result.map<ChatMessage>(ChatMessage.fromJson).toList();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
      return [];
    }
  }

  Future<void> receiveBotMessage(
    BuildContext context, {
    required ChatRoom room,
    required List<ChatMessage> chatHistories,
  }) async {
    try {
      final baseUrl = Uri.parse('https://api.openai.com/v1/chat/completions');
      final apiKey = dotenv.env['OPENAI_API_KEY'];
      final requestHeader = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      };
      final requestBody = jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "system",
              "content":
                  "you are a friendly bot that likes to chat about daily happenings in language they are asked with. reply should be less than 100 letters.",
            },
            ...chatHistories.reversed
                .map((message) => message.toApiJson())
                .toList(),
          ],
        },
      );
      final response =
          await http.post(baseUrl, headers: requestHeader, body: requestBody);
      final Map<String, dynamic> data = jsonDecode(response.body);
      final botMessage = data['choices'][0]['message']['content'];
      if (context.mounted) {
        await sendChatMessage(context,
            message: utf8.decode(botMessage.runes.toList()),
            room: room,
            fromBot: true);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
