import 'package:flutter/material.dart';

class ResendCodeText extends StatelessWidget {
  const ResendCodeText({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'If you don\'t receive code?',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Diphylleia',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Resend',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Sevillana',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
