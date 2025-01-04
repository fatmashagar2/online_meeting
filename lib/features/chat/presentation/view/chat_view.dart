
import 'package:flutter/material.dart';
import 'package:online_meeting/features/chat/presentation/view/widgets/chat_body.dart';

import 'chat_app_bar.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  static const String routeName = 'Ai Chat';

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const ChatAppBar(),
      body:ChatScreen()

    );
  }
}
