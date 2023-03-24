import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/blocs/chat/chat_events.dart';
import 'package:pastry/src/blocs/chat/chat_states.dart';
import '../../models/chat_message.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ChatBloc() : super(ChatInitial()) {
    on<FetchMessages>((event, emit) async {
      emit(ChatLoading());
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

        emit(ChatLoaded(messages: messages));
      } catch (e) {
        emit(ChatError(message: 'Error fetching messages: $e'));
      }
    });

    on<SendMessage>((event, emit) async {
      try {
        await _firestore.collection('messages').add({
          'content': event.chatMessage.content,
          'senderId': event.chatMessage.senderId,
          'timestamp': event.chatMessage.timestamp,
        });
      } catch (e) {
        emit(ChatError(message: 'Error sending message: $e'));
      }
    });
  }
}
