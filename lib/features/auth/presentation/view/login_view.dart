
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
      appBar: CustomAppBar(txt: "Login"),
      backgroundColor:  Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LoginImage(topPadding: 20,),

                // LoginTitle(title: 'LOGIN',),
                const SizedBox(height: 20),
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
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                  },
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Text("Forget Password?",)),
                ),
                const SizedBox(height: 30),
                CustomButton(text: 'Login', w: 375, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },),
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
