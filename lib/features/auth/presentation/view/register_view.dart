import 'dart:math';

import 'package:flutter/material.dart';
import 'package:online_meeting/features/auth/presentation/view/login_view.dart';
import 'package:online_meeting/features/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../main.dart';
import '../../../custom_button.dart';
import 'widgets/login_image.dart';
import 'widgets/login_link.dart';
import 'widgets/login_text_field.dart';
import 'widgets/login_title.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _obscureTextPassword = true;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _nameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);
    _phoneController.addListener(_validatePhone);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  void _validateEmail() {
    final value = _emailController.text;
    if (value.isEmpty) {
      setState(() {
        _emailError = 'Please enter your email';
      });
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
    } else {
      setState(() {
        _emailError = null;
      });
    }
  }

  void _validatePhone() {
    final value = _phoneController.text;
    if (value.isEmpty) {
      setState(() {
        _phoneError = 'Please enter your phone number';
      });
    } else if (value.length != 11) {
      setState(() {
        _phoneError = 'Please enter correct phone number';
      });
    } else {
      setState(() {
        _phoneError = null;
      });
    }
  }

  void _validatePassword() {
    final value = _passwordController.text;
    if (value.isEmpty) {
      setState(() {
        _passwordError = 'Please enter your password';
      });
    } else if (value.length < 6) {
      setState(() {
        _passwordError = 'Password must greater than 6 chars';
      });
    } else {
      setState(() {
        _passwordError = null;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(txt: "Register", isIconVisible: false,),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               // LoginImage(topPadding: 0),
                const SizedBox(height: 80),
              WavyLoginText(),
                const SizedBox(height: 40),
                LoginTextField(
                  controller: _nameController,
                  labelText: 'Name',
                  prefixIcon: Icons.person,
                  errorText: _nameError,
                  onSuffixIconPressed: () {},
                ),
                const SizedBox(height: 20),

                LoginTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  labelText: 'Email',
                  prefixIcon: Icons.email,
                  errorText: _emailError,
                  onSuffixIconPressed: () {},
                ),
                const SizedBox(height: 20),

                // Phone field
                LoginTextField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  labelText: 'Phone',
                  prefixIcon: Icons.phone,
                  errorText: _phoneError,
                  onSuffixIconPressed: () {},
                ),
                const SizedBox(height: 20),
                LoginTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: _obscureTextPassword,
                  errorText: _passwordError,
                  suffixIcon: _obscureTextPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onSuffixIconPressed: _togglePasswordVisibility,
                ),
                const SizedBox(height: 20),

                CustomButton(
                  text: 'Register',
                  w: 375,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final name = _nameController.text.trim();
                      final email = _emailController.text.trim();
                      final phone = _phoneController.text.trim();
                      final password = _passwordController.text;

                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );

                        await credential.user!.updateDisplayName(name);

                        // حفظ الاسم في SharedPreferences
                        final prefs = await SharedPreferences.getInstance();
                       await prefs.setString('displayName', name); // خزّن الاسم

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registered Successfully')),
                        );

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginView()),
                        );
                      } on FirebaseAuthException catch (e) {
                        String message = 'Registration failed';
                        if (e.code == 'email-already-in-use') {
                          message = 'This email is already in use';
                        } else if (e.code == 'weak-password') {
                          message = 'The password is too weak';
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(message)),
                        );
                      }
                    }
                  },

                ),
                const SizedBox(height: 20),
                LoginLink(
                  text: 'Already have an account? Login',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  },
                ),
              ],
            ),
          ),
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
  final String text = 'REGISTER';
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
      final end = min(start + 0.5, 1.0); // ← هنا بيتأكد إن end مش أكبر من 1.0

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
