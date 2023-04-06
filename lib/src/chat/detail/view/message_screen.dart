import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pastry/src/chat/detail/bloc/chat_bloc.dart';
import '../model/chat_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(FetchMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        listener: (context, state) {
          if (state is ChatError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: _buildChatList(state),
              ),
              _buildMessageInput(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildChatList(ChatState state) {
    if (state is ChatLoaded) {
      return ListView.builder(
        itemCount: state.messages.length,
        reverse: true,
        itemBuilder: (context, index) {
          ChatMessage message = state.messages[index];
          return ListTile(
            title: Text(message.content),
            subtitle: Text(message.senderId),
            trailing: Text(message.timestamp.toString()),
          );
        },
      );
    } else if (state is ChatLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Container();
    }
  }

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              decoration: InputDecoration(
                labelText: 'Type your message',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (_messageController.text.isNotEmpty) {
                context.read<ChatBloc>().add(
                      SendMessage(
                        chatMessage: ChatMessage(
                          id: '',
                          content: _messageController.text,
                          senderId: 'yourUserId',
                          timestamp: DateTime.now(),
                        ),
                      ),
                    );
                _messageController.clear();
              }
            },
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
