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

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);
}

extension ChatMessageExtension on ChatMessage {
  Map<String, dynamic> toApiJson() {
    final role = sender == senderToString(Sender.user) ? "user" : "assistant";
    return {
      "role": role,
      "content": message,
    };
  }
}

enum Sender {
  user,
  bot;
}

String senderToString(Sender sender) {
  return sender.toString().split('.').last;
}
