import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {
  const MessageTextField({super.key});

  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // テキスト入力欄を送信ボタンと横並びに設定
      child: const Row(
        children: [
          Expanded(
            child: TextField(),
          ),
          Icon(Icons.send),
        ],
      ),
    );
  }
}
