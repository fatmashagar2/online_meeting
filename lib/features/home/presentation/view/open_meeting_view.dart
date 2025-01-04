
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../auth/presentation/view/widgets/login_text_field.dart';
import '../../../custom_app_bar.dart';
import '../../../custom_button.dart';

class OpenMeetingPage extends StatelessWidget {
  OpenMeetingPage({super.key});

  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(txt: "Meeting Code"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: const Text(
                "Enter Meeting Code",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Diphylleia'),
              ),
            ),
            const SizedBox(height: 30),
            LoginTextField(controller: _codeController, labelText: "Code", prefixIcon: Icons.numbers),
            const SizedBox(height: 50),
            CustomButton(text: "Join", w: 375, onPressed: (){

            })
          ],
        ),
      ),
    );
  }
}
