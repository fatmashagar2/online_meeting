
import 'package:flutter/material.dart';

class ResetPasswordAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ResetPasswordAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF663399),
      leading: const BackButton(color: Colors.white),
      title: const Text(
        'Reset Password',
        style: TextStyle(color: Colors.white),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
