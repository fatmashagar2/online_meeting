import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/themes/theme_provider.dart';

class VerificationInstructionText extends StatelessWidget {
  const VerificationInstructionText({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // 🔹 استدعاء ThemeProvider

    return  Text(
      'Please enter the 4 digit code that send to your email address.',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: 'Diphylleia',
      ),
    );
  }
}
