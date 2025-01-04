import 'package:flutter/material.dart';

class ResetPasswordContinueButton extends StatelessWidget {
  const ResetPasswordContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // Handle password reset
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF663399),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Continue',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
