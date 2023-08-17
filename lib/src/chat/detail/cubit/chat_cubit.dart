import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatCubit extends Cubit {
  // TODO : Idk if poor form but it sure looks like it
  ChatCubit(super.initialState);

  Future<types.Room> createRoom(String sellerId) async {
    final room = await FirebaseChatCore.instance.createRoom(
      types.User(id: sellerId),
    );

    return room;
  }
}
