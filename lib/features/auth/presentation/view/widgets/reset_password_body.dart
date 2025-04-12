import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/reset_password_instruction_text.dart';
import 'package:online_meeting/main.dart';
import '../../../../custom_button.dart';
import 'login_text_field.dart';

class ResetPasswordBody extends StatelessWidget {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  ResetPasswordBody({super.key});

  // دالة لتحديث كلمة المرور
  Future<void> _updatePassword(BuildContext context) async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('كلمات المرور غير متطابقة'),
      ));
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // إذا كانت كلمات المرور متطابقة، نقوم بتحديث كلمة المرور
        await user.updatePassword(_passwordController.text);
        await user.reload(); // إعادة تحميل المستخدم بعد التحديث
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('تم تحديث كلمة المرور بنجاح'),
        ));

        // يمكنك الانتقال إلى شاشة أخرى أو العودة إلى الشاشة السابقة
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('حدث خطأ: ${e.toString()}'),
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
          SizedBox(height: 20),
          const ResetPasswordInstructionText(),
          const SizedBox(height: 30),
          LoginTextField(
            controller: _passwordController,
            suffixIcon: Icons.remove_red_eye,
            labelText: 'Password',
            prefixIcon: Icons.lock,
            obscureText: true,
          ),
          const SizedBox(height: 20),
          LoginTextField(
            controller: _confirmPasswordController,
            suffixIcon: Icons.remove_red_eye,
            labelText: 'Confirm Password',
            prefixIcon: Icons.lock,
            obscureText: true,
          ),
          const SizedBox(height: 50),
          CustomButton(
            text: "Continue",
            w: 375,
            onPressed: () => _updatePassword(context),
          ),
        ],
      ),
    );
  }
}
