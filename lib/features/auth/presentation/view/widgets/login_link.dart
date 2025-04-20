import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/themes/theme_provider.dart';

class LoginLink extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const LoginLink({Key? key, required this.onPressed, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // 🔹 استدعاء ThemeProvider

    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style:  TextStyle(color: themeProvider.isDarkMode ? Colors.white : Color(0xff092147)),
        ),
      ),
    );
  }
}
