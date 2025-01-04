import 'package:flutter/material.dart';
import 'package:online_meeting/features/auth/presentation/view/reset_password_screen.dart';

import '../../../../../main.dart';
import '../../../../custom_button.dart';

class VerificationVerifyButton extends StatelessWidget {
  const VerificationVerifyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Verify',
      w: 357,
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPasswordView()));
      },
    );
  }
}
