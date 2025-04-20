import 'package:flutter/material.dart';

import '../../../../custom_button.dart';

class ForgotPasswordSendButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ForgotPasswordSendButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Send Code',
      w: 357,
      onPressed: onPressed,
    );
  }
}
