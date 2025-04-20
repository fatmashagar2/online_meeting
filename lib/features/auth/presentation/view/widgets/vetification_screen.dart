import 'package:flutter/material.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/verification_body.dart';
import 'package:online_meeting/features/custom_app_bar.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(txt: 'Email Verification', isIconVisible: false,),
      body: const VerificationBody(),
    );
  }
}
