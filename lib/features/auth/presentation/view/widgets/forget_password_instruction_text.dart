import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/themes/theme_provider.dart';

class ForgotPasswordInstructionText extends StatelessWidget {
  const ForgotPasswordInstructionText({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // 🔹 استدعاء ThemeProvider

    return Center(
      child:  Text(
        'Enter A email address',
        style: TextStyle(
          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: "Diphylleia",
          fontSize: 20,
        ),
      ),
    );
  }
}
