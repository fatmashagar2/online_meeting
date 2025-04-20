import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_meeting/features/home/presentation/view/home_view.dart';
import '../reset_password_screen.dart';
import 'forget_password_instruction_text.dart';
import 'forget_send_button.dart';
import 'login_text_field.dart';

class ForgotPasswordBody extends StatelessWidget {
  final _emailController = TextEditingController();
  ForgotPasswordBody({super.key});

  // الدالة لإرسال رابط إعادة تعيين كلمة المرور
  Future<void> _resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني'),
      ));

      // الانتقال إلى صفحة إعادة تعيين كلمة المرور
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('حدث خطأ: ${e.message}'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          Center(
            child: Text( 'FORGET PASSWORD',style: TextStyle(
                fontFamily: 'Nosifer',fontSize: 20,color:Color(0xFF2E2E2E)
            ),),
          ),
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
    );
  }
}
