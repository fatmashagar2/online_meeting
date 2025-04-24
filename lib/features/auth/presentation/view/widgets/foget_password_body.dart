import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_meeting/features/home/presentation/view/home_view.dart';
import '../reset_password_screen.dart';
import 'forget_password_instruction_text.dart';
import 'forget_send_button.dart';
import 'login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'forget_password_instruction_text.dart';
import 'forget_send_button.dart';
import 'login_text_field.dart';

class ForgotPasswordBody extends StatelessWidget {
  final _emailController = TextEditingController();
  ForgotPasswordBody({super.key});

  Future<void> _resetPassword(BuildContext context) async {
    final email = _emailController.text;
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter an email address')),
      );
      return;
    }

    // Validate if the email is in correct format (basic check)
    final emailRegExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
    if (!emailRegExp.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Password reset link has been sent to your email.'),
      ));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${e.message}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView( // Wrap the column with a scroll view
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            WavyLoginText(),
            const SizedBox(height: 50),
            LoginTextField(
              controller: _emailController,
              labelText: 'Email',
              prefixIcon: Icons.email,
            ),
            const SizedBox(height: 100),
            ForgotPasswordSendButton(onPressed: () => _resetPassword(context)),
          ],
        ),
      ),
    );
  }
}


class WavyLoginText extends StatefulWidget {
  const WavyLoginText({super.key});

  @override
  State<WavyLoginText> createState() => _WavyLoginTextState();
}


class _WavyLoginTextState extends State<WavyLoginText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final String text = 'ForGet Password';
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animations = List.generate(text.length, (index) {
      final start = index * 0.1;
      final end = (start + 0.5 <= 1.0) ? start + 0.5 : 1.0;

      return Tween<double>(begin: 0.0, end: -10.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeInOut),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(text.length, (index) {
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animations[index].value),
                child: child,
              );
            },
            child: Text(
              text[index],
              style: const TextStyle(
                fontFamily: 'Nosifer',
                fontSize: 40,
                color: Color(0xFF2E2E2E),
              ),
            ),
          );
        }),
      ),
    );
  }
}
