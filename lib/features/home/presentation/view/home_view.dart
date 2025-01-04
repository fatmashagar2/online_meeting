import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_meeting/features/auth/presentation/view/widgets/login_text_field.dart';
import 'package:online_meeting/features/chat/presentation/view/widgets/chat_body.dart';
import 'package:online_meeting/features/custom_app_bar.dart';
import 'package:online_meeting/features/meeting_room/presentation/view/meeting_view.dart';
import 'package:online_meeting/main.dart';

import '../../../chat/presentation/view/chat_view.dart';
import '../../../profile/presentation/view/widgets/profile_screen.dart';
import 'open_meeting_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(txt: "Home Page"),
      body: Padding(
        padding: const EdgeInsets.only(top: 150, right: 16, left: 16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            HomeIcon(
              icon: Icons.video_call,
              label: "Create Meeting",
              onTap: () => _createMeeting(context),
            ),
            HomeIcon(
              icon: Icons.settings,
              label: "Settings",
              onTap: () => _openSettings(context),
            ),
            HomeIcon(
              icon: Icons.meeting_room,
              label: "Open Meeting",
              onTap: () => _openMeeting(context),
            ),
            HomeIcon(
              icon: Icons.message,
              label: "Chat",
              onTap: () => _showChat(context),
            ),
          ],
        ),
      ),
    );
  }

  void _createMeeting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ZoomMeetingPage()),
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
  }

  void _openMeeting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OpenMeetingPage()),
    );
  }

  void _showChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatView()),
    );
  }
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


