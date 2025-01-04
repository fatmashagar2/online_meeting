import 'package:flutter/material.dart';

class VerificationInstructionText extends StatelessWidget {
  const VerificationInstructionText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Please enter the 4 digit code that send to your email address.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'Diphylleia',
      ),
    );
  }
}
