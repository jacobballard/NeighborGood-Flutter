import 'package:flutter/material.dart';

class MessageHubPage extends StatefulWidget {
  const MessageHubPage({super.key});

  @override
  MessageHubPageState createState() => MessageHubPageState();
}

class MessageHubPageState extends State<MessageHubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: ListView.builder(itemBuilder: _buildMessageList),
    );
  }

  Widget _buildMessageList(BuildContext context, int index) {
    // let message = TODO : bloc messages

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Container(), // TODO : push conversation
        ),
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [Text("test")],
        ),
      ),
    );
  }
}
