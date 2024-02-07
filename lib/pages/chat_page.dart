import 'package:flutter/material.dart';
import 'package:flutter_back_golang/widgets/app_drawer.dart';
import 'package:flutter_back_golang/widgets/message_list.dart';
import 'package:flutter_back_golang/widgets/message_text_field.dart';

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
}
