import 'package:flutter/material.dart';

class ForgotPasswordInstructionText extends StatelessWidget {
  const ForgotPasswordInstructionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(
        'Enter A email address',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: "Diphylleia",
          fontSize: 20,
        ),
      ),
    );
  }
}
