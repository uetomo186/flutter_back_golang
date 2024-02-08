import 'package:flutter/material.dart';
import 'package:flutter_back_golang/models/chat_room.dart';
import 'package:flutter_back_golang/pages/chat_page.dart';
import 'package:flutter_back_golang/widgets/chat_room_edit_dialog.dart';

class AppDrawerListTile extends StatelessWidget {
  const AppDrawerListTile({
    super.key,
    required this.room,
  });

  final ChatRoom room;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.comment),
      title: Text(room.name),
      onTap: () {
        //チャットページの差し替え
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ChatPage(room: room)),
        );
      },
      trailing: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return ChatRoomEditDialog(room: room);
            },
          );
        },
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
