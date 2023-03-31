part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class FetchMessages extends ChatEvent {}

class SendMessage extends ChatEvent {
  final ChatMessage chatMessage;

  const SendMessage({required this.chatMessage});

  @override
  List<Object> get props => [chatMessage];
}
