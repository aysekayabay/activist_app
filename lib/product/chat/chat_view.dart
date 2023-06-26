import 'package:akademi_bootcamp/core/model/group_model.dart';
import 'package:flutter/material.dart';

class ChatView extends StatefulWidget {
  final GroupModel groupModel;
  const ChatView({super.key, required this.groupModel});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
    );
  }
}
