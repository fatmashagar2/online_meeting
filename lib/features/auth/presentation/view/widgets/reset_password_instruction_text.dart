import 'package:flutter/material.dart';

class ResetPasswordInstructionText extends StatelessWidget {
  const ResetPasswordInstructionText({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Enter New Password',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Diphylleia'
        ),
      ),
    );
  }
}
