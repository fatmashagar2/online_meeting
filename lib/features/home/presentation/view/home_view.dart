import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../main.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _conferenceIdController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isMeetingStarted = false;
  final user = FirebaseAuth.instance.currentUser;
  String displayName = 'User';
  bool isAdmin = false; // ✅ متغير جديد

  @override
  void initState() {
    super.initState();
    _loadDisplayName();
    _checkIfAdmin(); // ✅ تحقق من الإيميل
  }

  void _checkIfAdmin() {
    if (user?.email == "admin@gmail.com") {
      setState(() {
        isAdmin = true;
      });
    }
  }

  final GlobalKey _globalKey = GlobalKey();

  Future<void> _loadDisplayName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString('displayName') ?? 'User';
    });
  }

  String _generateRoomId() {
    return 'room';
  }
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar( backgroundColor: Color(0xFF1E1F22),centerTitle: true,title: const Text("Home Page",  style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Diphylleia',
        ),), automaticallyImplyLeading: false),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      if (isAdmin)
                      Text(
                        "Hi Admin",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      if (isAdmin)
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => MeetingScreen(roomId: _generateRoomId()),
                    ));
                  },
                  child: const Text(
                    "Let's Go",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Color(0xFF1E1F22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // هنا تم إضافة الـ border radius
                    ),
                  ),
                ),
              ),

              // ✅ عرض زر Create Quiz فقط لو المستخدم أدمن
              if (isAdmin)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CreateQuestionScreen()),
                      );
                    },
                    child: const Text(
                      "Create Quiz",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Color(0xFF1E1F22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0), // هنا تم إضافة الـ border radius
                      ),
                    ),
                  ),
                ),

            ],
          ),
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
  CameraController? _cameraController;
  late List<CameraDescription> cameras;
  late CameraDescription camera;
  Timer? _screenshotTimer;
  bool _isCameraInitialized = false;

  final String _serverUrl = "https://8x8.vc/vpaas-magic-cookie-cdc1bc8812454841af7f495cccd69fc6";
  final String _tenant = "EDU%20FOCUS";
  final JitsiMeet _jitsiMeet = JitsiMeet();

  @override
  void initState() {
    super.initState();
    _startMeeting(); // أول حاجة نبدأ الميتينج
    Future.delayed(const Duration(seconds: 5), () async {
      await _initCamera(); // وبعدها الكاميرا تشتغل عادي
      _startScreenshotTimer(); // وابدأ التصوير كل شوية
    });
  }

  Future<void> _initCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      cameras = await availableCameras();
      camera = cameras.firstWhere(
            (cam) => cam.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
      _cameraController = CameraController(camera, ResolutionPreset.high);
      await _cameraController!.initialize();
      setState(() {
        _isCameraInitialized = true;
      });
    } else {
      debugPrint("❌ Camera permission not granted");
    }
  }


  String _generateRoomId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    final randomString = List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
    return 'room_$randomString';
  }

  Future<void> _startMeeting() async {
    try {
      final roomId = _generateRoomId();
      final options = JitsiMeetConferenceOptions(
        serverURL: _serverUrl,
        room: "$_tenant/$roomId",
        configOverrides: {
          "startWithAudioMuted": true,
          "startWithVideoMuted": true,
          "prejoinPageEnabled": false,
          "videoMuted": true,
        },
        featureFlags: {
          "pip.enabled": true,
          "invite.enabled": true,
          "live-streaming.enabled": false,
          "meeting-password.enabled": false,
          "recording.enabled": false,
          "tile-view.enabled": false,
          "videoMute.enabled": false,
          "audio-only.enabled": true,
          "audioMute.enabled": false,
          "welcomePage.enabled": false,
          "camera.enabled": false,
        },
        userInfo: JitsiMeetUserInfo(
          displayName: "فاطمه",
          email: "fatmashagar64@gmail.com",
        ),
      );

      final listener = JitsiMeetEventListener(
        conferenceJoined: (String url) {
          debugPrint("✅ تم الانضمام إلى الاجتماع: $url");
        },
        conferenceTerminated: (String url, Object? error) {
          debugPrint("⛔ انتهى الاجتماع: $url");
        },
        participantJoined: (email, name, role, participantId) {
          debugPrint("👤 انضم: $name");
        },
      );

      await _jitsiMeet.join(options, listener);
    } catch (e) {
      debugPrint("🔥 خطأ أثناء بدء الميتينج: ${e.toString()}");
    }
  }

  void _startScreenshotTimer() {
    _screenshotTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _takePicture();
    });
  }

  Future<void> _takePicture() async {
    try {
      if (_cameraController != null && _cameraController!.value.isInitialized) {
        final image = await _cameraController!.takePicture();
        final directory = Directory("/storage/emulated/0/Pictures/MyAppScreenshots");
        if (!(await directory.exists())) {
          await directory.create(recursive: true);
        }
        final filePath = '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final file = File(filePath);
        await file.writeAsBytes(await image.readAsBytes());
        debugPrint("✅ Screenshot saved to: $filePath");
      }
    } catch (e) {
      debugPrint("❌ Error taking picture: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meeting")),
      body: _isCameraInitialized
          ? Stack(
        children: [
          CameraPreview(_cameraController!),
          Center(child: Text("Joining meeting ${widget.roomId}...")),
        ],
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _screenshotTimer?.cancel();
    super.dispose();
  }
}
