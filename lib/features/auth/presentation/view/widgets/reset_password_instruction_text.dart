import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/themes/theme_provider.dart';

class ResetPasswordInstructionText extends StatelessWidget {
  const ResetPasswordInstructionText({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // 🔹 استدعاء ThemeProvider

    return Center(
      child: Text(
        'Enter New Password',
        style: TextStyle(
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Diphylleia'
        ),
      ),
    );
  }
}
