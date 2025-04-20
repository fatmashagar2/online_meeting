
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../main.dart';
import '../../../auth/presentation/view/widgets/login_text_field.dart';
import '../../../custom_app_bar.dart';
import '../../../custom_button.dart';

class OpenMeetingPage extends StatefulWidget {
  OpenMeetingPage({super.key});

  @override
  State<OpenMeetingPage> createState() => _OpenMeetingPageState();
}

class _OpenMeetingPageState extends State<OpenMeetingPage> {
  final TextEditingController _conferenceIdController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _joinConference({required bool isCreating}) async {
    final String conferenceId = isCreating
        ? const Uuid().v4().substring(0, 8)
        : _conferenceIdController.text.trim();

    if (!isCreating && conferenceId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a Conference ID to join")),
      );
      return;
    }

    if (isCreating) {
      await _firestore.collection("meetings").doc(conferenceId).set({
        "createdAt": Timestamp.now(),
      });
    } else {
      final doc = await _firestore.collection("meetings").doc(conferenceId).get();
      if (!doc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Meeting ID does not exist")),
        );
        return;
      }
    }

    final String userId = const Uuid().v4().substring(0, 6);
    final String userName = "User_$userId";

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => VedoiConfernce(
    //       confernceID: conferenceId,
    //       userID: userId,
    //       userName: userName,
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(txt: "Meeting Code", isIconVisible: false,),
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
            LoginTextField(controller: _conferenceIdController, labelText: "Code", prefixIcon: Icons.numbers),
            const SizedBox(height: 50),
            CustomButton(text: "Join", w: 375,
              onPressed: () => _joinConference(isCreating: false),
            )
          ],
        ),
      ),
    );
  }
}
