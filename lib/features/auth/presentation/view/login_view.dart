
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_meeting/features/auth/presentation/view/forget_password_view.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/login_image.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/login_link.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/login_text_field.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/login_title.dart';
import 'package:online_meeting/features/auth/presentation/view/register_view.dart';
import 'package:online_meeting/features/custom_app_bar.dart';
import 'package:online_meeting/features/home/presentation/view/home_view.dart';

import '../../../../main.dart';
import '../../../custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _obscureText = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateEmail);
    _passwordController.addListener(_validatePassword);
  }
  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        // محاولة تسجيل الدخول باستخدام Firebase Auth
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // إذا كان تسجيل الدخول ناجحًا، انتقل إلى الشاشة الرئيسية
        // إذا كان تسجيل الدخول ناجحًا، احفظ الحالة وانتقل إلى الشاشة الرئيسية
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );

      } on FirebaseAuthException catch (e) {
        // عرض الأخطاء إذا حدث خطأ في تسجيل الدخول
        if (e.code == 'user-not-found') {
          setState(() {
            _emailError = 'لا يوجد مستخدم بهذا البريد الإلكتروني';
          });
        } else if (e.code == 'wrong-password') {
          setState(() {
            _passwordError = 'كلمة المرور غير صحيحة';
          });
        } else {
          // إضافة حالة أخرى في حال حدوث خطأ آخر
          setState(() {
            _emailError = 'حدث خطأ أثناء تسجيل الدخول';
            _passwordError = 'يرجى التحقق من البيانات';
          });
        }
      }
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // المستخدم لغى عملية تسجيل الدخول
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('Success');

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // حفظ حالة تسجيل الدخول في SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
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

  void _validatePassword() {
    final value = _passwordController.text;
    if (value.isEmpty) {
      setState(() {
        _passwordError = 'Please enter your password';
      });
    }
    else  if (value.length<6) {
      setState(() {
        _passwordError = 'Password must greater than 6 chars';
      });
    }
    else {
      setState(() {
        _passwordError = null;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(txt: "Login", isIconVisible: false),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 80),
                WavyLoginText(),
                const SizedBox(height: 80),
                LoginTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  labelText: 'Email',
                  prefixIcon: Icons.email,
                  errorText: _emailError,
                ),
                const SizedBox(height: 20),
                LoginTextField(

                  controller: _passwordController,
                  labelText: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: _obscureText,
                  suffixIcon: _obscureText ? Icons.visibility : Icons.visibility_off,
                  onSuffixIconPressed: _togglePasswordVisibility,
                  errorText: _passwordError,
                ),
                const SizedBox(height: 20),
                // InkWell(
                //   onTap: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                //   },
                //   child: Align(
                //       alignment: Alignment.topRight,
                //       child: Text("Forget Password?",)),
                // ),
                // const SizedBox(height: 30),
                CustomButton(text: 'Login', w: 375, onPressed:
                  _login
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'Login With Google',
                  w: 375,
                  onPressed: () async {
                    final userCredential = await signInWithGoogle();
                    if (userCredential != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen())); // غيري '/home' لو اسم الراوت مختلف
                    } else {
                      print('Login cancelled or failed');
                    }
                  },
                ),

                const SizedBox(height: 20),
                LoginLink(
                  text:   'Don\'t have an account? Register',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterView()),
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
  final String text = 'LOGIN';
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200), // 🔥 أسرع
      vsync: this,
    )..repeat(reverse: true);

    _animations = List.generate(text.length, (index) {
      final start = index * 0.1;
      final end = start + 0.5;
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
