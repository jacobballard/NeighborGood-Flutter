
import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String id;
  final String content;
  final String senderId;
  final DateTime timestamp;

  ChatMessage(
      {required this.id,
      required this.content,
      required this.senderId,
      required this.timestamp});

  @override
  List<Object> get props => [id, content, senderId, timestamp];
}
