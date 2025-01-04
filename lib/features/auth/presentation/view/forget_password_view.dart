import 'package:flutter/material.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/foget_password_body.dart';
import '../../../../main.dart';
import '../../../custom_app_bar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: CustomAppBar(txt: "Forgot Password"),
      body:  ForgotPasswordBody(),
    );
  }
}
















