import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/bloc/chat_events.dart';
import 'package:pastry/src/bloc/chat_states.dart';
import '../models/chat_message.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial());
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is FetchMessages) {
      yield ChatLoading();
      try {
        QuerySnapshot querySnapshot = await _firestore
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .get();

        List<ChatMessage> messages = querySnapshot.docs.map((doc) {
          return ChatMessage(
            id: doc.id,
            content: doc['content'],
            senderId: doc['senderId'],
            timestamp: doc['timestamp'].toDate(),
          );
        }).toList();

        yield ChatLoaded(messages: messages);
      } catch (e) {
        yield ChatError(message: 'Error fetching messages: $e');
      }
    } else if (event is SendMessage) {
      try {
        await _firestore.collection('messages').add({
          'content': event.chatMessage.content,
          'senderId': event.chatMessage.senderId,
          'timestamp': event.chatMessage.timestamp,
        });
      } catch (e) {
        yield ChatError(message: 'Error sending message: $e');
      }
    }
  }
}
