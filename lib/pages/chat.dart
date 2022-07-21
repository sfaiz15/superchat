import 'package:superchat/model/conversation.dart';
import 'package:superchat/model/message.dart';
import 'package:superchat/services/firestore_service.dart';
import 'package:superchat/style/style.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_rating_bar/flutter_rating_bar';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key, required this.conversation, required this.name})
      : super(key: key);
  final String name;
  final Conversation conversation;
  final FirestoreService _fs = FirestoreService();
  final TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SafeArea(
          child: Column(
        children: [_messagingArea(context), _inputArea(context)],
      )),
    );
  }

  Widget _messagingArea(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.pink,
      width: screenWidth(context),
      child: StreamBuilder<List<Message>>(
        stream: _fs.messages,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messages = [];
            for (var message in snapshot.data!) {
              if (message.convoId == conversation.id) {
                messages.add(message);
              }
            }
            return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool me = messages[index].fromId == _fs.getUserId();
                  return Container(
                      color: me ? Colors.amber : Colors.deepPurple,
                      child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            messages[index].content,
                            textAlign: me ? TextAlign.right : TextAlign.left,
                          )));
                });
          } else {
            return const Center(
              child: Text("No messages have loaded"),
            );
          }
        },
      ),
    ));
  }

  Widget _inputArea(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      width: screenWidth(context),
      height: 100,
      child: Row(children: [
        const SizedBox(width: 20),
        Expanded(
            child: TextField(
          controller: _message,
          minLines: 1,
          maxLines: 3,
        )),
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.send))
      ]),
    );
  }

  void sendMessage() {
    if (_message.text.isNotEmpty) {
      _fs.addMessage(_message.text, conversation);
      _message.clear();
    }
  }
}
