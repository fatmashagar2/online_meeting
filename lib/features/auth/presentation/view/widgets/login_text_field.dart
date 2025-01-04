import 'package:flutter/material.dart';

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
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: Color(0xff092147),
      ),
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xff092147)),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color:  Color(0xff092147)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color:  Color(0xff092147)),
        ),
        prefixIcon: Icon(prefixIcon, color:  Color(0xff092147)),
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon, color:  Color(0xff092147)),
          onPressed: onSuffixIconPressed,
        )
            : null,
        errorText: errorText,
      ),
    );
  }
}
