import 'package:flutter/material.dart';
import 'package:flutter_back_golang/models/chat_room.dart';

class ChatRoomEditDialog extends StatefulWidget {
  const ChatRoomEditDialog({
    super.key,
    required this.room,
  });

  final ChatRoom room;

  @override
  State<ChatRoomEditDialog> createState() => _ChatRoomEditDialogState();
}

class _ChatRoomEditDialogState extends State<ChatRoomEditDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.room.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('チャットルームの編集'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'チャットルーム名',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_controller.text);
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
