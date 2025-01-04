
import 'package:flutter/material.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/reset_password_continue_body.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/reset_password_field.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/reset_password_instruction_text.dart';
import 'package:online_meeting/main.dart';

import '../../../../custom_button.dart';
import 'login_text_field.dart';

class ResetPasswordBody extends StatelessWidget {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
   ResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          const ResetPasswordInstructionText(),
          const SizedBox(height: 30),
          LoginTextField(controller: _passwordController, suffixIcon: Icons.remove_red_eye, labelText: 'Password',prefixIcon: Icons.lock,obscureText: true,),
          const SizedBox(height: 20),
          LoginTextField(controller: _confirmPasswordController, suffixIcon: Icons.remove_red_eye, labelText: 'Confirm Password',prefixIcon: Icons.lock,obscureText: true,),
          const SizedBox(height: 50),
           CustomButton(text: "Continue", w: 375, onPressed: (){

          }),
        ],
      ),
    );
  }
}
