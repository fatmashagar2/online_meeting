import 'package:flutter/material.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/resend_code_text.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/verification_code_field.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/verification_instruction_text.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/verification_verify_button.dart';

class VerificationBody extends StatelessWidget {
  const VerificationBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const VerificationInstructionText(),
          const SizedBox(height: 30),
          const VerificationCodeFields(),
          const SizedBox(height: 50),
          const ResendCodeText(),
          const SizedBox(height: 50),
          VerificationVerifyButton(),
        ],
      ),
    );
  }
}
