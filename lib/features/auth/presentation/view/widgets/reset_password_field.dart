import 'package:flutter/material.dart';

class ResetPasswordField extends StatelessWidget {
  final String label;

  const ResetPasswordField({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: const Icon(Icons.visibility_off),
      ),
    );
  }
}
