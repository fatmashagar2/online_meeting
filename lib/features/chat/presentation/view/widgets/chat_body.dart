import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custome_widget.dart';
import 'message_input_field.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  List<Widget> _messages = [];

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      String textToSend = _controller.text;

      String translatedText = textToSend;

      setState(() {
        _messages.add(
          CustomMessageWidget(
            gradientColors: [Color(0xff164992), Color(0xff5AA6F4)],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15.r),
              topLeft: Radius.circular(15.r),
              bottomRight: Radius.circular(15.r),
            ),
            imagePath: "assets/img3.jpeg",
            txt: translatedText,
            isYou: false,
          ),
        );
        _controller.clear();
        _scrollToBottom();

        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _messages.add(
              CustomMessageWidget(
                gradientColors: [Color(0xff164992), Color(0xff5AA6F4)],
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15.r),
                  topRight: Radius.circular(15.r),
                  bottomLeft: Radius.circular(15.r),
                ),
                imagePath: "assets/img3.jpeg",
                isYou: true,
                txt: 'Hello',
              ),
            );
            _scrollToBottom();
          });
        });
      });
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onTextChanged(String text) {
    setState(() {
      _isTyping = text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _messages[index];
              },
            ),
          ),
          MessageInputField(
            controller: _controller,
            onTextChanged: _onTextChanged,
            onSendMessage: _sendMessage,
          ),
        ],
      ),
    );
  }
}
