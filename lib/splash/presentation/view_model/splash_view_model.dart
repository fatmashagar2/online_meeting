
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../features/auth/presentation/view/login_view.dart';

class SplashViewModel {
  Future<void> navigateToAppropriatePage(BuildContext context) async {
     await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>  LoginView(), // غيّر اسم الصفحة لو مختلف
      ),
    );
  }
}