import 'package:flutter/material.dart';


import 'forget_password_instruction_text.dart';
import 'forget_send_button.dart';
import 'login_text_field.dart';

class ForgotPasswordBody extends StatelessWidget {
  final _emailController = TextEditingController();
   ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ForgotPasswordInstructionText(),
          const SizedBox(height: 50),
          LoginTextField(controller: _emailController, labelText: 'Email', prefixIcon: Icons.email,),
          const SizedBox(height: 100),
          ForgotPasswordSendButton(),
        ],
      ),
    );
  }
}
