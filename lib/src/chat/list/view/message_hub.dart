import 'package:flutter/material.dart';

class MessageHubPage extends StatefulWidget {
  @override
  _MessageHubPageState createState() => _MessageHubPageState();
}

class _MessageHubPageState extends State<MessageHubPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
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
          children: [Text("test")],
        ),
      ),
    );
  }
}
