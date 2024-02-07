class ChatMessage {
  const ChatMessage({
    this.id,
    required this.roomId,
    required this.message,
    required this.sender,
    required this.createdAt,
  });
  final String? id;
  final String roomId;
  final String message;
  final String sender;
  final DateTime createdAt;
}

enum Sender {
  user,
  bot;
}
