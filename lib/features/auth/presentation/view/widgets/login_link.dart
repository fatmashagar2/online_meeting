import 'package:flutter/material.dart';

class LoginLink extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const LoginLink({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Color(0xff092147)),
        ),
      ),
    );
  }
}
