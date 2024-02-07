import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message.freezed.dart';
part 'chat_message.g.dart';

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    String? id,
    required String roomId,
    required String message,
    required String sender,
    required DateTime createdAt,
  }) = _ChatMessage;
  // final String? id;
  // final String roomId;
  // final String message;
  // final String sender;
  // final DateTime createdAt;
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

enum Sender {
  user,
  bot;
}
