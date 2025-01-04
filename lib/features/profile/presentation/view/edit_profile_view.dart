import 'package:flutter/material.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/login_text_field.dart';

import '../../../../main.dart';
import '../../../custom_button.dart';

class EditProfileView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController PhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/img3.jpeg'),
              ),
            ),
            SizedBox(height: 30),
            LoginTextField(controller: nameController, labelText: "Name", prefixIcon: Icons.person),
            SizedBox(height: 20),
            LoginTextField(controller: emailController, labelText: "Email", prefixIcon: Icons.email),

            SizedBox(height: 20),
            LoginTextField(controller: PhoneController, labelText: "Phone", prefixIcon: Icons.phone),

            SizedBox(height: 20),
            LoginTextField(controller: PasswordController, labelText: "Password", prefixIcon: Icons.remove_red_eye),

            SizedBox(height: 90),
            CustomButton(
              text: 'Save',
              w: 375,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
