import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/themes/theme_provider.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String? errorText;
  final String labelText;
  final IconData prefixIcon;
  final VoidCallback? onSuffixIconPressed;
  final IconData? suffixIcon;
  final TextInputType keyboardType;
  const LoginTextField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    this.obscureText = false,
    this.errorText,
    this.onSuffixIconPressed,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // 🔹 استدعاء ThemeProvider

    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: themeProvider.isDarkMode ? Colors.white : Color(0xff092147),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle:  TextStyle(color: themeProvider.isDarkMode ? Colors.white :Color(0xff092147)),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: themeProvider.isDarkMode ? Colors.white :  Color(0xff092147)),
        ),
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: themeProvider.isDarkMode ? Colors.white :  Color(0xff092147)),
        ),
        prefixIcon: Icon(prefixIcon, color: themeProvider.isDarkMode ? Colors.white :  Color(0xff092147)),
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon,color: themeProvider.isDarkMode ? Colors.white :  Color(0xff092147)),
          onPressed: onSuffixIconPressed,
        )
            : null,
        errorText: errorText,
      ),
    );
  }
}
