import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/themes/theme_provider.dart';

class ResendCodeText extends StatelessWidget {
  const ResendCodeText({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // 🔹 استدعاء ThemeProvider

    return TextButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text(
            'If you don\'t receive code?',
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              fontFamily: 'Diphylleia',
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Resend',
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              fontFamily: 'Sevillana',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
