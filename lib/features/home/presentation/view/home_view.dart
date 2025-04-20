import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/login_text_field.dart';
import 'package:online_meeting/features/chat/presentation/view/widgets/chat_body.dart';
import 'package:online_meeting/features/custom_app_bar.dart';
import 'package:online_meeting/features/meeting_room/presentation/view/meeting_view.dart';
import 'package:online_meeting/main.dart';
import 'package:uuid/uuid.dart';

import '../../../chat/presentation/view/chat_view.dart';
import '../../../custom_button.dart';
import '../../../notification/ConcentrationNotifications.dart';
import '../../../profile/presentation/view/widgets/profile_screen.dart';
import 'open_meeting_view.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _conferenceIdController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isMeetingStarted = false; // متغير لتحديد إذا ما كان الميتنج بدأ

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
      final doc =
          await _firestore.collection("meetings").doc(conferenceId).get();
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
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          txt: "Home Page",
          isIconVisible: false,
        ),
        body: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [Text("Hi Fatma",style: TextStyle(fontWeight: FontWeight.bold),), Image.asset("assets/wave.gif",width: 30,height: 30,)
                 ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Image.asset("assets/img.png"),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: "Let's Go",
                w: double.infinity,
                onPressed: () {
                  _startMeeting();
                },
              ),
            ) ,SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: "Create Quiz",
                w: double.infinity,
                onPressed: () {
                 //Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateQuestionScreen()));
                },
              ),
            )
          ],
        )),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        children: [
          SpeedDialChild(
              child: Icon(Icons.message), label: "Message", onTap: () {}),
          SpeedDialChild(
              child: Icon(Icons.camera), label: "Camera", onTap: () {}),
        ],
      ),
    );// إخفاء الزر العائم إذا لم يبدأ الاجتماع


  }

  final JitsiMeet _jitsiMeet = JitsiMeet();
  final String _serverUrl =
      "https://8x8.vc/vpaas-magic-cookie-99476734cde9462aa129ec8010493317";
  final String _tenant = "EDU%20FOCUS";

  String _generateRoomId() {
    return 'room';
  }

  Future<void> _startMeeting() async {
    try {
      final roomId = _generateRoomId();

      final options = JitsiMeetConferenceOptions(
        serverURL: _serverUrl,
        room: "$_tenant/$roomId", // Tenant + Room Name
        configOverrides: {
          "startWithAudioMuted": true,
          "startWithVideoMuted": true,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: "فاطمه (مشرفة)",
          email: "fatmashagar64@gmail.com",
        ),
      );

      await _jitsiMeet.join(options, JitsiMeetEventListener());

      // بعد بدء الميتنج، نعرض الزر العائم
      setState(() {
        isMeetingStarted = true;
      });

      debugPrint('isMeetingStarted = $isMeetingStarted');

    } catch (e) {
      debugPrint("خطأ: $e");
    }
  }

// void _openSettings(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => ProfileScreen()),
//   );
// }

// void _openMeeting(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => OpenMeetingPage()),
//   );
// }
//
// void _showChat(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) => ConcentrationNotifications()),
//   );
// }
}

class HomeIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const HomeIcon({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [Color(0xff092147), Color(0xff1E54A6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xff1E54A6).withOpacity(0.5),
              blurRadius: 8.8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border(
            bottom: BorderSide(
              color: Color(0xff1E54A6),
              width: 0.5.w,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
