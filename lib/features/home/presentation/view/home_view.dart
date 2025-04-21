import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _conferenceIdController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isMeetingStarted = false;

  final GlobalKey _globalKey = GlobalKey(); // ✅ حل مشكلة undefined name

  final JitsiMeet _jitsiMeet = JitsiMeet();
  final String _serverUrl =
      "https://8x8.vc/vpaas-magic-cookie-cdc1bc8812454841af7f495cccd69fc6";
  final String _tenant = "EDU%20FOCUS";

  Timer? _screenshotTimer;

  String _generateRoomId() {
    return 'room';
  }

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

    // هنا ممكن تضيف شاشة الاجتماع لاحقًا
  }


  Future<void> _takeScreenshot() async {
    try {
      // تأكد من وجود الصلاحية
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        debugPrint("❌ Storage permission not granted");
        return;
      }

      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        // اسم الملف
        final String fileName = "screenshot_${DateTime.now().millisecondsSinceEpoch}.png";

        // مجلد داخل Pictures
        final Directory directory = Directory("/storage/emulated/0/Pictures/MyAppScreenshots");
        if (!(await directory.exists())) {
          await directory.create(recursive: true);
        }

        final File imgFile = File('${directory.path}/$fileName');
        await imgFile.writeAsBytes(pngBytes);

        debugPrint("✅ Screenshot saved to: ${imgFile.path}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ تم حفظ الصورة في المعرض")),
        );
      }
    } catch (e) {
      debugPrint("❌ Error taking screenshot: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ فشل في حفظ الصورة")),
      );
    }
  }

  Future<void> _startMeeting() async {
    try {
      final roomId = _generateRoomId();

      // بعد انشاء الاجتماع، انتقل إلى شاشة الاجتماع
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MeetingScreen(roomId: "$_tenant/$roomId"),
        ),
      );

      setState(() {
        isMeetingStarted = true;
      });

      _screenshotTimer = Timer.periodic(Duration(seconds: 10), (timer) {
        _takeScreenshot();
      });
    } catch (e) {
      debugPrint("خطأ: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Home Page"), automaticallyImplyLeading: false),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      const Text("Hi Fatma", style: TextStyle(fontWeight: FontWeight.bold)),
                      Image.asset("assets/wave.gif", width: 30, height: 30),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Image.asset("assets/img.png"),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _startMeeting,
                  child: const Text("Let's Go"),
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // انتقل إلى شاشة إنشاء الأسئلة
                  },
                  child: const Text("Create Quiz"),
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.message),
              label: "Message",
              onTap: () {},
            ),
            SpeedDialChild(
              child: const Icon(Icons.camera),
              label: "Camera",
              onTap: () {},
            ),
          ],
        ),
      ),
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
class MeetingScreen extends StatefulWidget {
  final String roomId;

  MeetingScreen({required this.roomId});

  @override
  _MeetingScreenState createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  final JitsiMeet _jitsiMeet = JitsiMeet();
  final GlobalKey _globalKey = GlobalKey();
  Timer? _screenshotTimer;

  @override
  void initState() {
    super.initState();
    _joinMeeting();
    _startScreenshotTimer();
  }

  Future<void> _joinMeeting() async {
    try {
      final options = JitsiMeetConferenceOptions(
        serverURL: "https://8x8.vc/vpaas-magic-cookie-cdc1bc8812454841af7f495cccd69fc6",
        room: widget.roomId,
        configOverrides: {
          "startWithAudioMuted": true,
          "startWithVideoMuted": true,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: "Fatma",
          email: "fatmashagar64@gmail.com",
        ),
      );

      await _jitsiMeet.join(options);
    } catch (e) {
      debugPrint("خطأ في الانضمام للاجتماع: $e");
    }
  }

  Future<void> _takeScreenshot() async {
    try {
      // تأكد من وجود الصلاحية
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        debugPrint("❌ Storage permission not granted");
        return;
      }

      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        // اسم الملف
        final String fileName = "screenshot_${DateTime.now().millisecondsSinceEpoch}.png";

        // مجلد داخل Pictures
        final Directory directory = Directory("/storage/emulated/0/Pictures/MyAppScreenshots");
        if (!(await directory.exists())) {
          await directory.create(recursive: true);
        }

        final File imgFile = File('${directory.path}/$fileName');
        await imgFile.writeAsBytes(pngBytes);

        debugPrint("✅ Screenshot saved to: ${imgFile.path}");
      }
    } catch (e) {
      debugPrint("❌ Error taking screenshot: $e");
    }
  }

  void _startScreenshotTimer() {
    _screenshotTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      _takeScreenshot();
    });
  }

  @override
  void dispose() {
    _screenshotTimer?.cancel(); // إلغاء التوقيت عند مغادرة الشاشة
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey, // استخدم المفتاح هنا
      child: Scaffold(
        appBar: AppBar(title: const Text("Meeting")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Joining meeting ${widget.roomId}..."),
              // هنا يمكن إضافة واجهة المستخدم الخاصة بك للمزيد من التفاصيل
            ],
          ),
        ),
      ),
    );
  }
}
