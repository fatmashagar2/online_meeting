import 'package:flutter/material.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/reset_password_app_bar.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/reset_password_body.dart';
import 'package:online_meeting/features/custom_app_bar.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:CustomAppBar(txt: "Reset Password", isIconVisible: false,),
      body:  ResetPasswordBody(),
    );
  }
}
