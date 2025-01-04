
import 'package:flutter/material.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/vetification_screen.dart';
import 'package:online_meeting/main.dart';

import '../../../../custom_button.dart';

class ForgotPasswordSendButton extends StatelessWidget {
  const ForgotPasswordSendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Send Code',
      w: 357,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VerificationScreen()),
        );
      },
    );
  }
}
