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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
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
  late BuildContext myContext;
  final JitsiMeet _jitsiMeet = JitsiMeet();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      myContext = context; // ✅ نحفظ الـ context هنا
    });
    _loadDisplayName();
    _checkIfAdmin(); // ✅ تحقق من الإيميل
  }
  Future<void> _startMeeting() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final displayName = user?.displayName ?? 'User'; // الاسم من Firebase

      // تخزين الاسم في Firestore عند دخول الميتينج
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': displayName,
        'email': user.email,
        'joinedAt': DateTime.now(),
      });

      final roomId = _generateRoomId();
      var options = JitsiMeetConferenceOptions(
        room: roomId.replaceAll(' ', '').toLowerCase(),
        serverURL: "https://meet.ffmuc.net",
        featureFlags: {
          "toolbar.enabled": true,
          "welcome-page.enabled": false,
          "prejoinpage.enabled": false,
          "chat.enabled": true,
          "invite.enabled": true,
          "meeting-name.enabled": true,
          "lobby-mode.enabled": true,
          "raise-hand.enabled": true,
          "video-share.enabled": true,
          "recording.enabled": true,
          "livestreaming.enabled": true,
          "screen-sharing.enabled": true,
          "calendar.enabled": false,
          "close-captions.enabled": true,
          "pip.enabled": true,
          "tile-view.enabled": true,
        },
        configOverrides: {
          "startWithVideoMuted": true,
          "startWithAudioMuted": true,
          "subject": "Edu Focus",
          "toolbarButtons": [
            "camera",
            "chat",
            "closedcaptions",
            "desktop",
            "download",
            "fullscreen",
            "hangup",
            "help",
            "invite",
            "livestreaming",
            "microphone",
            "mute-everyone",
            "mute-video-everyone",
            "profile",
            "raisehand",
            "recording",
            "security",
            "select-background",
            "settings",
            "shareaudio",
            "sharedvideo",
            "shortcuts",
            "stats",
            "tileview",
            "toggle-camera",
            "videoquality",
          ],
        },
        userInfo: JitsiMeetUserInfo(
          displayName: displayName,
          email: user?.email,
        ),
      );

      debugPrint('Joining meeting with configured options...');

      var listener = JitsiMeetEventListener(
          conferenceJoined: (url) {
            debugPrint("Event: Conference joined - URL: $url");
          },
          participantJoined: (email, name, role, participantId) {
            debugPrint(
              "Event: Participant joined - Name: $name, Role: $role, Email: $email, Participant ID: $participantId",
            );
          },
          conferenceTerminated: (url, error) async {
            debugPrint("Event: Conference terminated - URL: $url, Error: $error");

            if (mounted) {
              // استنى فريم جديد بعد انتهاء المؤتمر
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => NamesListPage()),
                );
              });
            }
          }

      );

      await _jitsiMeet.join(options, listener);
    } catch (e) {
      debugPrint("🔥 خطأ أثناء بدء الميتينج: ${e.toString()}");
    }
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
                    Navigator.push(context,MaterialPageRoute(builder:(context)=> MeetingScreen(roomId: _generateRoomId(),)));
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

  final String _serverUrl = "https://meet.ffmuc.net/";
  final JitsiMeet _jitsiMeet = JitsiMeet();
  final user = FirebaseAuth.instance.currentUser;
  int _counter = 0; // العد من 0
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 10), () {
      _startTimer();
    });
    _startMeeting(); // أول حاجة نبدأ الميتينج
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

  @override
  void dispose() {
    _cameraController?.dispose();
    _screenshotTimer?.cancel();
    _timer.cancel();
    super.dispose();
    super.dispose();
  }

  String _generateRoomId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    final randomString = List.generate(6, (index) => chars[random.nextInt(chars.length)]).join();
    return 'room_';
  }

  Future<void> _startMeeting() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final displayName = user?.displayName ?? 'User'; // الاسم من Firebase

      // تخزين الاسم في Firestore عند دخول الميتينج
      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': displayName,
        'email': user.email,
        'joinedAt': DateTime.now(),
      });

      final roomId = _generateRoomId();
      var options = JitsiMeetConferenceOptions(
        room: roomId.replaceAll(' ', '').toLowerCase(),
        serverURL: "https://meet.ffmuc.net",
        featureFlags: {
          "toolbar.enabled": true,
          "welcome-page.enabled": false,
          "prejoinpage.enabled": false,
          "chat.enabled": true,
          "invite.enabled": true,
          "meeting-name.enabled": true,
          "lobby-mode.enabled": true,
          "raise-hand.enabled": true,
          "video-share.enabled": true,
          "recording.enabled": true,
          "livestreaming.enabled": true,
          "screen-sharing.enabled": true,
          "calendar.enabled": false,
          "close-captions.enabled": true,
          "pip.enabled": true,
          "tile-view.enabled": true,
        },
        configOverrides: {
          "startWithVideoMuted": true,
          "startWithAudioMuted": true,
          "subject": "Edu Focus",
          "toolbarButtons": [
            "camera",
            "chat",
            "closedcaptions",
            "desktop",
            "download",
            "fullscreen",
            "hangup",
            "help",
            "invite",
            "livestreaming",
            "microphone",
            "mute-everyone",
            "mute-video-everyone",
            "profile",
            "raisehand",
            "recording",
            "security",
            "select-background",
            "settings",
            "shareaudio",
            "sharedvideo",
            "shortcuts",
            "stats",
            "tileview",
            "toggle-camera",
            "videoquality",
          ],
        },
        userInfo: JitsiMeetUserInfo(
          displayName: displayName,
          email: user?.email,
        ),
      );

      debugPrint('Joining meeting with configured options...');

      var listener = JitsiMeetEventListener(
        conferenceJoined: (url) {
          debugPrint("Event: Conference joined - URL: $url");
        },
        participantJoined: (email, name, role, participantId) {
          debugPrint(
            "Event: Participant joined - Name: $name, Role: $role, Email: $email, Participant ID: $participantId",
          );
        },
        conferenceTerminated: (url, error) {
          debugPrint("🔥 Conference Terminated - URL: $url, Error: $error");
          debugPrint("Attempting to navigate to NamesListPage...");
          try {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => StudentFocusApp(timeElapsed: _counter,)),
            );
            debugPrint("✅ Navigation successful!");
          } catch (e) {
            debugPrint("❌ Navigation error: $e");
          }
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
  late Timer _timer;


  void _startTimer() {
    // بدء العد بشكل دوري كل ثانية
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter++;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,  // يوسّط عمودياً
          children: [
            Text(
              "Meeting in progress...",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentFocusApp(timeElapsed: _counter),
                  ),
                );
              },
              child: Text(
                "Time elapsed: $_counter ",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
  // زرار يعرض كل الأسماء المخزنة في Firestore (لـ الأدمن فقط)
  Widget _showAllNamesButton() {
    return ElevatedButton(
      onPressed: () async {
        final snapshot = await FirebaseFirestore.instance.collection('users').get();
        final names = snapshot.docs.map((doc) => doc['name']).toList();

        for (var name in names) {
          print("👤 $name");
        }
      },
      child: Text("عرض كل الأسماء"),
    );
  }


class NamesListPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("All Accounts")),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No accounts found."));
          }

          final accounts = snapshot.data!.docs;

          return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final name = accounts[index]['name'];
              final email = accounts[index]['email'];
              return ListTile(
                title: Text(name),
                subtitle: Text(email),
              );
            },
          );
        },
      ),
    );
  }
}




class FatmaFocusApp extends StatelessWidget {
  const FatmaFocusApp({Key? key}) : super(key: key);

  // دالة لتوليد بيانات عشوائية زي ما في StudentTab
  List<Map<String, dynamic>> generateRandomData() {
    final random = Random();
    const notesList = [
      'Highly attentive',
      'Asking smart questions',
      'Helping peers',
      'Taking detailed notes',
      'Discussing complex ideas',
      'Solving problems quickly',
      'Explaining concepts',
      'Summarizing key points',
    ];
    return List.generate(8, (index) {
      final focus = random.nextInt(101); // 0 to 100
      final engagement = random.nextInt(101); // 0 to 100
      final notes = notesList[random.nextInt(notesList.length)];
      final time = '${(index * 15).toString().padLeft(2, '0')}:00-${((index + 1) * 15).toString().padLeft(2, '0')}:00';
      return {
        'time': time,
        'focus': focus,
        'engagement': engagement,
        'notes': notes,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fatma Focus Analysis',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 14),
          bodyMedium: TextStyle(fontSize: 14),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FatmaDashboard(data: generateRandomData()), // تمرير البيانات العشوائية
    );
  }
}
class FatmaDashboard extends StatefulWidget {
  final List<Map<String, dynamic>> data; // البيانات اللي هتيجي من برا

  const FatmaDashboard({Key? key, required this.data}) : super(key: key);

  @override
  State<FatmaDashboard> createState() => _FatmaDashboardState();
}
class _FatmaDashboardState extends State<FatmaDashboard> {
  // Learning style data (دي ثابتة زي ما هي)
  final List<Map<String, dynamic>> learningStyleData = [
    {'style': 'Visual', 'percentage': 40},
    {'style': 'Auditory', 'percentage': 35},
    {'style': 'Kinesthetic', 'percentage': 25},
  ];

  // Focus triggers (دي ثابتة زي ما هي)
  final List<Map<String, dynamic>> focusTriggers = [
    {'trigger': 'Group work', 'impact': 'High engagement'},
    {'trigger': 'Video content', 'impact': 'High focus'},
    {'trigger': 'Discussion', 'impact': 'Very high engagement'},
    {'trigger': 'Reading', 'impact': 'Medium focus'},
  ];

  double getAverageFocus() {
    return widget.data.map((entry) => entry['focus'] as int).reduce((a, b) => a + b) / widget.data.length;
  }

  double getLowestFocus() {
    return widget.data.map((entry) => entry['focus'] as int).reduce((min, value) => min < value ? min : value).toDouble();
  }

  double getHighestFocus() {
    return widget.data.map((entry) => entry['focus'] as int).reduce((max, value) => max > value ? max : value).toDouble();
  }

  String getMostProductiveTime() {
    var maxEntry = widget.data.reduce((current, next) => current['focus'] > next['focus'] ? current : next);
    return maxEntry['time'] as String;
  }

  String getLeastProductiveTime() {
    var minEntry = widget.data.reduce((current, next) => current['focus'] < next['focus'] ? current : next);
    return minEntry['time'] as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fatma\'s Focus Analysis'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStudentHeader(),
                const SizedBox(height: 12),
                _buildFocusOverview(),
                const SizedBox(height: 12),
                _buildFocusChart(),
                const SizedBox(height: 12),
                _buildLearningStyleAnalysis(),
                const SizedBox(height: 12),
                _buildFocusTriggers(),
                const SizedBox(height: 12),
                _buildRecommendations(),
                const SizedBox(height: 12),
                _buildDetailedTimeAnalysis(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStudentHeader() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.green.shade100,
              child: const Text(
                'F',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fatma',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Average Focus: ${getAverageFocus().toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Status: Excellent Performance',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusOverview() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.analytics, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Focus Summary',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: _buildOverviewItem(
                    icon: Icons.trending_down,
                    title: 'Lowest',
                    value: '${getLowestFocus().toInt()}%',
                    color: Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildOverviewItem(
                    icon: Icons.trending_up,
                    title: 'Highest',
                    value: '${getHighestFocus().toInt()}%',
                    color: Colors.green.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildOverviewItem(
                    icon: Icons.access_time,
                    title: 'Best Time',
                    value: getMostProductiveTime(),
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildOverviewItem(
                    icon: Icons.access_time_filled,
                    title: 'Worst Time',
                    value: getLeastProductiveTime(),
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildFocusChart() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.show_chart, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Focus Levels During Class',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 200,
              child: _buildLineChart(),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pattern: Consistently high focus throughout the session',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 20,
          verticalInterval: 1,
        ),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() % 2 == 0 && value.toInt() < widget.data.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.data[value.toInt()]['time'].toString().split('-')[0],
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}%',
                  style: const TextStyle(fontSize: 10),
                );
              },
              reservedSize: 30,
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        minX: 0,
        maxX: widget.data.length - 1.0,
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              widget.data.length,
                  (index) => FlSpot(index.toDouble(), widget.data[index]['focus'].toDouble()),
            ),
            isCurved: true,
            color: Colors.green,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.green.withOpacity(0.2),
            ),
          ),
          LineChartBarData(
            spots: List.generate(
              widget.data.length,
                  (index) => FlSpot(index.toDouble(), widget.data[index]['engagement'].toDouble()),
            ),
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningStyleAnalysis() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.psychology, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Learning Style Analysis',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: learningStyleData.length,
              itemBuilder: (context, index) {
                final style = learningStyleData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          style['style'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: style['percentage'] / 100,
                          backgroundColor: Colors.grey.shade200,
                          color: _getLearningStyleColor(style['style']),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${style['percentage']}%',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            const Text(
              'Recommendation: Balanced learning approach with mix of materials',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Color _getLearningStyleColor(String style) {
    switch (style) {
      case 'Visual':
        return Colors.blue;
      case 'Auditory':
        return Colors.green;
      case 'Kinesthetic':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  Widget _buildFocusTriggers() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.battery_charging_full, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Focus Triggers',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: focusTriggers.length,
              itemBuilder: (context, index) {
                final trigger = focusTriggers[index];
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    _getTriggerIcon(trigger['trigger']),
                    color: _getTriggerColor(trigger['impact']),
                    size: 20,
                  ),
                  title: Text(
                    trigger['trigger'],
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    trigger['impact'],
                    style: TextStyle(
                      fontSize: 12,
                      color: _getTriggerColor(trigger['impact']),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTriggerIcon(String trigger) {
    switch (trigger) {
      case 'Group work':
        return Icons.group;
      case 'Video content':
        return Icons.videocam;
      case 'Discussion':
        return Icons.chat;
      case 'Reading':
        return Icons.book;
      default:
        return Icons.help;
    }
  }

  Color _getTriggerColor(String impact) {
    switch (impact) {
      case 'High engagement':
        return Colors.green;
      case 'High focus':
        return Colors.green.shade700;
      case 'Very high engagement':
        return Colors.teal;
      case 'Medium focus':
        return Colors.lightGreen;
      default:
        return Colors.grey;
    }
  }

  Widget _buildRecommendations() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Personal Recommendations',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            const ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.star, color: Colors.amber, size: 20),
              title: Text('Lead group study sessions'),
              subtitle: Text('Help peers while reinforcing your knowledge'),
            ),
            const ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.auto_awesome, color: Colors.purple, size: 20),
              title: Text('Advanced materials'),
              subtitle: Text('Explore challenging topics beyond curriculum'),
            ),
            const ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.school, color: Colors.blue, size: 20),
              title: Text('Give presentations'),
              subtitle: Text('Share knowledge with classmates'),
            ),
            const ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.psychology_alt, color: Colors.green, size: 20),
              title: Text('Critical thinking exercises'),
              subtitle: Text('Analyze complex concepts in depth'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedTimeAnalysis() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.analytics_outlined, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Detailed Time Analysis',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.data.length,
              itemBuilder: (context, index) {
                final entry = widget.data[index];
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    children: [
                      Text(
                        entry['time'],
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getFocusLevelColor(entry['focus']),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${entry['focus']}%',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    entry['notes'],
                    style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getFocusLevelColor(int focus) {
    if (focus >= 90) return Colors.green.shade800;
    if (focus >= 80) return Colors.green;
    if (focus >= 70) return Colors.lightGreen;
    return Colors.orange;
  }
}


class HagerFocusApp extends StatelessWidget {

  const HagerFocusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hager Focus Analysis',
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.red,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 14),
          bodyMedium: TextStyle(fontSize: 14),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HagerDashboard(),
    );
  }
}

class HagerDashboard extends StatefulWidget {
  const HagerDashboard({Key? key}) : super(key: key);

  @override
  State<HagerDashboard> createState() => _HagerDashboardState();
}

class _HagerDashboardState extends State<HagerDashboard> {
  // Hager's data (low focus)
  final List<Map<String, dynamic>> hagerData = [
    {'time': '0:00-0:15', 'focus': 55, 'engagement': 50, 'notes': 'Distracted from start'},
    {'time': '0:15-0:30', 'focus': 48, 'engagement': 45, 'notes': 'Not participating'},
    {'time': '0:30-0:45', 'focus': 52, 'engagement': 48, 'notes': 'On phone'},
    {'time': '0:45-1:00', 'focus': 40, 'engagement': 38, 'notes': 'Disengaged'},
    {'time': '1:00-1:15', 'focus': 58, 'engagement': 52, 'notes': 'Struggling to focus'},
    {'time': '1:15-1:30', 'focus': 45, 'engagement': 42, 'notes': 'Yawning frequently'},
    {'time': '1:30-1:45', 'focus': 50, 'engagement': 48, 'notes': 'Not following along'},
    {'time': '1:45-2:00', 'focus': 52, 'engagement': 50, 'notes': 'Rushing to finish'},
  ];

  // Additional historical data
  final List<Map<String, dynamic>> historicalData = [
    {'date': 'May 1', 'focus': 45},
    {'date': 'May 2', 'focus': 50},
    {'date': 'May 3', 'focus': 48},
    {'date': 'May 4', 'focus': 52},
    {'date': 'May 5', 'focus': 46},
    {'date': 'May 6', 'focus': 50},
    {'date': 'May 7', 'focus': 49},
  ];

  // Learning style data
  final List<Map<String, dynamic>> learningStyleData = [
    {'style': 'Visual', 'percentage': 60},
    {'style': 'Auditory', 'percentage': 25},
    {'style': 'Kinesthetic', 'percentage': 15},
  ];

  // Focus triggers
  final List<Map<String, dynamic>> focusTriggers = [
    {'trigger': 'Group work', 'impact': 'High distraction'},
    {'trigger': 'Video content', 'impact': 'Medium focus'},
    {'trigger': 'Discussion', 'impact': 'Low engagement'},
    {'trigger': 'Reading', 'impact': 'Very low focus'},
  ];

  double getAverageFocus() {
    return hagerData.map((entry) => entry['focus'] as int).reduce((a, b) => a + b) / hagerData.length;
  }

  double getLowestFocus() {
    return hagerData.map((entry) => entry['focus'] as int).reduce((min, value) => min < value ? min : value).toDouble();
  }

  double getHighestFocus() {
    return hagerData.map((entry) => entry['focus'] as int).reduce((max, value) => max > value ? max : value).toDouble();
  }

  String getMostProductiveTime() {
    var maxEntry = hagerData.reduce((current, next) => current['focus'] > next['focus'] ? current : next);
    return maxEntry['time'] as String;
  }

  String getLeastProductiveTime() {
    var minEntry = hagerData.reduce((current, next) => current['focus'] < next['focus'] ? current : next);
    return minEntry['time'] as String;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hager\'s Focus Analysis'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStudentHeader(),
                const SizedBox(height: 12),
                _buildFocusOverview(),
                const SizedBox(height: 12),
                _buildFocusChart(),
                const SizedBox(height: 12),
                // _buildWeeklyProgressReport(),
                const SizedBox(height: 12),
                _buildLearningStyleAnalysis(),
                const SizedBox(height: 12),
                _buildFocusTriggers(),
                const SizedBox(height: 12),
                _buildRecommendations(),
                const SizedBox(height: 12),
                _buildDetailedTimeAnalysis(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStudentHeader() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.red.shade100,
              child: const Text(
                'H',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hager',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Average Focus: ${getAverageFocus().toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Status: Needs Improvement',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusOverview() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.analytics, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'Focus Summary',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: _buildOverviewItem(
                    icon: Icons.trending_down,
                    title: 'Lowest',
                    value: '${getLowestFocus().toInt()}%',
                    color: Colors.red.shade700,
                  ),
                ),
                Expanded(
                  child: _buildOverviewItem(
                    icon: Icons.trending_up,
                    title: 'Highest',
                    value: '${getHighestFocus().toInt()}%',
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildOverviewItem(
                    icon: Icons.access_time,
                    title: 'Best Time',
                    value: getMostProductiveTime(),
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildOverviewItem(
                    icon: Icons.access_time_filled,
                    title: 'Worst Time',
                    value: getLeastProductiveTime(),
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildFocusChart() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.show_chart, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'Focus Levels During Class',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 200,
              child: _buildLineChart(),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pattern: Focus drops significantly after the first hour',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          horizontalInterval: 20,
          verticalInterval: 1,
        ),
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() % 2 == 0 && value.toInt() < hagerData.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      hagerData[value.toInt()]['time'].toString().split('-')[0],
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 20,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}%',
                  style: const TextStyle(fontSize: 10),
                );
              },
              reservedSize: 30,
            ),
          ),
        ),
        borderData: FlBorderData(show: true),
        minX: 0,
        maxX: hagerData.length - 1.0,
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              hagerData.length,
                  (index) => FlSpot(index.toDouble(), hagerData[index]['focus'].toDouble()),
            ),
            isCurved: true,
            color: Colors.red,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.red.withOpacity(0.2),
            ),
          ),
          LineChartBarData(
            spots: List.generate(
              hagerData.length,
                  (index) => FlSpot(index.toDouble(), hagerData[index]['engagement'].toDouble()),
            ),
            isCurved: true,
            color: Colors.orange,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.orange.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildWeeklyProgressReport() {
  //   return Card(
  //     elevation: 2,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const Row(
  //             children: [
  //               Icon(Icons.calendar_today, color: Colors.red),
  //               SizedBox(width: 8),
  //               Text(
  //                 'Weekly Progress',
  //                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //               ),
  //             ],
  //           ),
  //           const Divider(),
  //           SizedBox(
  //             height: 180,
  //             child: _buildWeeklyChart(),
  //           ),
  //           const SizedBox(height: 8),
  //           Text(
  //             'Average Weekly Focus: ${historicalData.map((e) => e['focus'] as int).reduce((a, b) => a + b) / historicalData.length}%',
  //             style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  //           ),
  //           const Text(
  //             'Consistency: Low (High Variability)',
  //             style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildWeeklyChart() {
  //   return LineChart(
  //     LineChartData(
  //       gridData: FlGridData(
  //         show: true,
  //         drawVerticalLine: true,
  //         horizontalInterval: 20,
  //         verticalInterval: 1,
  //       ),
  //       titlesData: FlTitlesData(
  //         topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //         rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
  //         bottomTitles: AxisTitles(
  //           sideTitles: SideTitles(
  //             showTitles: true,
  //             getTitlesWidget: (value, meta) {
  //               if (value.toInt() >= 0 && value.toInt() < historicalData.length) {
  //                 return Padding(
  //                   padding: const EdgeInsets.only(top: 8.0),
  //                   child: Text(
  //                     historicalData[value.toInt()]['date'].toString(),
  //                     style: const TextStyle(fontSize: 10),
  //                   ),
  //                 );
  //               }
  //               return const Text('');
  //             },
  //             reservedSize: 30,
  //           ),
  //         ),
  //         leftTitles: AxisTitles(
  //           sideTitles: SideTitles(
  //             showTitles: true,
  //             interval: 20,
  //             getTitlesWidget: (value, meta) {
  //               return Text(
  //                 '${value.toInt()}%',
  //                 style: const TextStyle(fontSize: 10),
  //               );
  //             },
  //             reservedSize: 30,
  //           ),
  //         ),
  //       ),
  //       borderData: FlBorderData(show: true),
  //       minX: 0,
  //       maxX: historicalData.length - 1.0,
  //       minY: 0,
  //       maxY: 100,
  //       lineBarsData: [
  //         LineChartBarData(
  //           spots: List.generate(
  //             historicalData.length,
  //                 (index) => FlSpot(index.toDouble(), historicalData[index]['focus'].toDouble()),
  //           ),
  //           isCurved: true,
  //           color: Colors.purple,
  //           barWidth: 3,
  //           isStrokeCapRound: true,
  //           dotData: FlDotData(show: true),
  //           belowBarData: BarAreaData(
  //             show: true,
  //             color: Colors.purple.withOpacity(0.2),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildLearningStyleAnalysis() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.psychology, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'Learning Style Analysis',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: learningStyleData.length,
              itemBuilder: (context, index) {
                final style = learningStyleData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: Text(
                          style['style'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: style['percentage'] / 100,
                          backgroundColor: Colors.grey.shade200,
                          color: _getLearningStyleColor(style['style']),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${style['percentage']}%',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            const Text(
              'Recommendation: Use more visual learning materials',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Color _getLearningStyleColor(String style) {
    switch (style) {
      case 'Visual':
        return Colors.blue;
      case 'Auditory':
        return Colors.green;
      case 'Kinesthetic':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  Widget _buildFocusTriggers() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.battery_alert, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'Focus Triggers',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: focusTriggers.length,
              itemBuilder: (context, index) {
                final trigger = focusTriggers[index];
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    _getTriggerIcon(trigger['trigger']),
                    color: _getTriggerColor(trigger['impact']),
                    size: 20,
                  ),
                  title: Text(
                    trigger['trigger'],
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                    trigger['impact'],
                    style: TextStyle(
                      fontSize: 12,
                      color: _getTriggerColor(trigger['impact']),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _getTriggerIcon(String trigger) {
    switch (trigger) {
      case 'Group work':
        return Icons.group;
      case 'Video content':
        return Icons.videocam;
      case 'Discussion':
        return Icons.chat;
      case 'Reading':
        return Icons.book;
      default:
        return Icons.help;
    }
  }

  Color _getTriggerColor(String impact) {
    switch (impact) {
      case 'High distraction':
        return Colors.red;
      case 'Medium focus':
        return Colors.orange;
      case 'Low engagement':
        return Colors.amber;
      case 'Very low focus':
        return Colors.red.shade900;
      default:
        return Colors.grey;
    }
  }

  Widget _buildRecommendations() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'Personal Recommendations',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            const ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.schedule, color: Colors.orange, size: 20),
              title: Text('Take short breaks every 20 minutes'),
              subtitle: Text('Helps reset attention span'),
            ),
            const ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.visibility, color: Colors.blue, size: 20),
              title: Text('Use visual study aids'),
              subtitle: Text('Flashcards, diagrams, and mind maps'),
            ),
            const ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.smartphone, color: Colors.red, size: 20),
              title: Text('Use phone focus mode'),
              subtitle: Text('Minimize distractions during study'),
            ),
            const ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.front_hand, color: Colors.purple, size: 20),
              title: Text('Sit in the front row'),
              subtitle: Text('Reduces visual distractions'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedTimeAnalysis() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.analytics_outlined, color: Colors.red),
                SizedBox(width: 8),
                Text(
                  'Detailed Time Analysis',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: hagerData.length,
              itemBuilder: (context, index) {
                final entry = hagerData[index];
                return ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Row(
                    children: [
                      Text(
                        entry['time'],
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getFocusLevelColor(entry['focus']),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '${entry['focus']}%',
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    entry['notes'],
                    style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color _getFocusLevelColor(int focus) {
    if (focus >= 80) return Colors.green;
    if (focus >= 60) return Colors.amber;
    if (focus >= 40) return Colors.orange;
    return Colors.red;
  }
}

class StudentFocusApp extends StatelessWidget {
  final int timeElapsed;

  const StudentFocusApp({Key? key, required this.timeElapsed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Focus Analysis',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: FocusAnalysisDashboard(timeElapsed: timeElapsed), // تم التعديل هنا
    );
  }
}

class FocusAnalysisDashboard extends StatefulWidget {
  final int timeElapsed;

  const FocusAnalysisDashboard({Key? key, required this.timeElapsed}) : super(key: key);

  @override
  State<FocusAnalysisDashboard> createState() => _FocusAnalysisDashboardState();
}

class _FocusAnalysisDashboardState extends State<FocusAnalysisDashboard> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> userNames = [];
  bool isLoading = true;

  // جلب المستخدمين من Firestore
  Future<void> fetchUsers() async {
    final user = FirebaseAuth.instance.currentUser;
    final snapshot = await FirebaseFirestore.instance.collection('users').get();

    // جلب الأسماء مع استبعاد "admin"
    final allNames = snapshot.docs
        .map((doc) => doc['name'] as String)
        .where((name) => name.toLowerCase() != 'admin')
        .toList();

    // تخصيص التاب للمستخدم Fatma إذا كان الايميل هو fatma@gmail.com
    if (user != null && user.email == 'fatma@gmail.com') {
      userNames = allNames.where((name) => name.toLowerCase() == 'fatma').toList();
      _tabController = TabController(length: userNames.length, vsync: this); // فقط تاب Fatma
    } else {
      userNames = allNames;
      _tabController = TabController(length: userNames.length + 1, vsync: this); // +1 للـ Overall
    }

    setState(() {
      isLoading = false;
    });
  }

  // توليد بيانات عشوائية
  List<Map<String, dynamic>> generateRandomData() {
    final random = Random();
    return List.generate(widget.timeElapsed ~/ 120, (index) {
      final focus = random.nextInt(86) + 15; // القيمة بين 15 و 100
      final engagement = random.nextInt(100);
      int totalMinutes = (index + 1) * 2;
      int hours = totalMinutes ~/ 60;
      int minutes = totalMinutes % 60;
      return {
        'time': '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:00',
        'focus': focus,
        'engagement': engagement,
        'notes': 'Note for $index',
      };
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final allData = userNames.map((_) => generateRandomData()).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Focus Analysis', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            ...userNames.map((name) => Tab(text: name)), // تبويبات الطلاب
            const Tab(text: 'Overall Report'), // تبويب الـ Overall
          ],
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // تبويبات الطلاب
          ...List.generate(userNames.length, (index) {
            return StudentTab(studentName: userNames[index], data: allData[index]);
          }),

          // تبويب الـ Overall
          OverallReportTab(
            hagerData: allData[0],
            fatmaData: allData.length > 1 ? allData[1] : [],
          ),
        ],
      ),
    );
  }
}

class StudentTab extends StatelessWidget {
  final String studentName;
  final List<Map<String, dynamic>> data;

  const StudentTab({
    Key? key,
    required this.studentName,
    required this.data,
  }) : super(key: key);

  int getAverageFocus() {
    return (data.map((entry) => entry['focus'] as int).reduce((a, b) => a + b) / data.length).round();
  }

  @override
  Widget build(BuildContext context) {
    final avgFocus = getAverageFocus();
    final isHager = studentName == 'Hager';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStudentHeader(context, isHager),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildFocusSummary(avgFocus),
                  const SizedBox(height: 16),
                  AspectRatio(
                    aspectRatio: 1.7,
                    child: _buildLineChart(avgFocus, isHager),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildRecommendations(avgFocus.toDouble())

            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detailed Data',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildDataTable(isHager),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentHeader(BuildContext context, bool isHager) {
    final avgFocus = getAverageFocus();

    Color getFocusColor(double avgFocus) {
      if (avgFocus >= 90) return Colors.green;
      if (avgFocus >= 75) return Colors.lightGreen;
      if (avgFocus >= 50) return Colors.orange;
      return Colors.red;
    }

    final Color avatarColor = getFocusColor(avgFocus.toDouble()); // ← اللون حسب النسبة

    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: avatarColor.withOpacity(0.2), // ← خفيفة للخلفية
          child: Text(
            studentName[0],
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: avatarColor, // ← لون الحرف
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              studentName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap:(){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FatmaFocusApp()),
                );
              },
              child: Text(
                'Avg Focus: ${avgFocus.toInt()}%',
                style: TextStyle(
                  fontSize: 16,
                  color: avatarColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
  Color getFocusColor(final avgFocus) {
    if (avgFocus >= 90) return Colors.green;
    if (avgFocus >= 75) return Colors.lightGreen;
    if (avgFocus >= 50) return Colors.orange;
    return Colors.red;
  }
  Widget _buildLineChart(int avgFocus, bool isHager) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}%',
                  style: const TextStyle(fontSize: 10),
                );
              },
              reservedSize: 30,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < data.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      data[value.toInt()]['time'].toString().split('-')[0],
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        minX: 0,
        maxX: data.length - 1.0,
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              data.length,
                  (index) => FlSpot(index.toDouble(), data[index]['focus'].toDouble()),
            ),
            isCurved: true,
            color: getFocusColor(avgFocus), // ← هنا يتم استخدام اللون بناءً على النسبة
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: getFocusColor(avgFocus).withOpacity(0.2), ),
          ),
        ],
      ),
    );
  }
  Widget _buildFocusSummary(final avgFocus) {
    late Color focusColor;
    late String focusText;
    late IconData icon;

    if (avgFocus >= 90) {
      focusColor = Colors.green;
      focusText = 'Excellent Focus';
      icon = Icons.star;
    } else if (avgFocus >= 75) {
      focusColor = Colors.lightGreen;
      focusText = 'Good Focus';
      icon = Icons.check_circle;
    } else if (avgFocus >= 50) {
      focusColor = Colors.orange;
      focusText = 'Average Focus';
      icon = Icons.warning;
    } else {
      focusColor = Colors.red;
      focusText = 'Low Focus';
      icon = Icons.error;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: focusColor, size: 30),
        const SizedBox(width: 8),
        Column(
          children: [
            Text(
              'Focus Level',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            Text(
              focusText,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: focusColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecommendations(double avgFocus) {
    Color focusColor;
    String performanceText;
    List<Widget> suggestionList;

    if (avgFocus >= 90) {
      focusColor = Colors.green;
      performanceText = 'Excellent Performance';
      suggestionList = [
        ListTile(
          leading: Icon(Icons.star, color: Colors.green),
          title: Text('Excellent Focus'),
          subtitle: Text('You are doing great! Keep up the excellent work.'),
        ),
        ListTile(
          leading: Icon(Icons.auto_awesome, color: Colors.purple),
          title: Text('Development Suggestions'),
          subtitle: Text('1. Lead study groups\n2. Give presentations\n3. Enrichment materials'),
        ),
      ];
    } else if (avgFocus >= 75) {
      focusColor = Colors.lightGreen;
      performanceText = 'Good Performance';
      suggestionList = [
        ListTile(
          leading: Icon(Icons.check_circle, color: Colors.lightGreen),
          title: Text('Good Focus'),
          subtitle: Text('You are doing well! Continue with consistent effort.'),
        ),
        ListTile(
          leading: Icon(Icons.help, color: Colors.orange),
          title: Text('Suggestions for Improvement'),
          subtitle: Text('1. Stay consistent\n2. Take regular breaks\n3. Avoid distractions'),
        ),
      ];
    } else if (avgFocus >= 50) {
      focusColor = Colors.orange;
      performanceText = 'Average Performance';
      suggestionList = [
        ListTile(
          leading: Icon(Icons.warning, color: Colors.orange),
          title: Text('Average Focus'),
          subtitle: Text('You can improve your focus with better planning and attention.'),
        ),
        ListTile(
          leading: Icon(Icons.help_outline, color: Colors.yellow),
          title: Text('Suggestions for Improvement'),
          subtitle: Text('1. Set clear goals\n2. Minimize distractions\n3. Shorter study sessions'),
        ),
      ];
    } else {
      focusColor = Colors.red;
      performanceText = 'Low Performance';
      suggestionList = [
        ListTile(
          leading: Icon(Icons.error, color: Colors.red),
          title: Text('Low Focus'),
          subtitle: Text('You need to improve your focus significantly.'),
        ),
        ListTile(
          leading: Icon(Icons.school, color: Colors.blue),
          title: Text('Suggestions for Improvement'),
          subtitle: Text('1. Seek help from a mentor\n2. Set up a study schedule\n3. Minimize distractions'),
        ),
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recommendations',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...suggestionList,
      ],
    );
  }

  Widget _buildDataTable(bool isHager) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Time')),
          DataColumn(label: Text('Focus')),
          DataColumn(label: Text('Notes')),
        ],
        rows: data.map((entry) {
          return DataRow(
            cells: [
              DataCell(Text(entry['time'].toString())),
              DataCell(
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getFocusColor(entry['focus'], isHager),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${entry['focus']}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              DataCell(Text(entry['notes'].toString())),
            ],
          );
        }).toList(),
      ),
    );
  }

  Color _getFocusColor(int focusValue, bool isHager) {
    if (isHager) {
      if (focusValue >= 60) return Colors.orange;
      return Colors.red;
    } else {
      if (focusValue >= 90) return Colors.green;
      if (focusValue >= 80) return Colors.lightGreen;
      return Colors.orange;
    }
  }
}

class OverallReportTab extends StatelessWidget {
  final List<Map<String, dynamic>> hagerData;
  final List<Map<String, dynamic>> fatmaData;

  const OverallReportTab({
    Key? key,
    required this.hagerData,
    required this.fatmaData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hagerAvg = hagerData.map((entry) => entry['focus'] as int).reduce((a, b) => a + b) / hagerData.length;
    final fatmaAvg = fatmaData.map((entry) => entry['focus'] as int).reduce((a, b) => a + b) / fatmaData.length;
    final overallAvg = (hagerAvg + fatmaAvg) / 2;
    final avgDiff = (hagerAvg - fatmaAvg).abs();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overall Report',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Performance Comparison',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildComparisonItem('Hager', hagerAvg),
                      _buildComparisonItem('Fatma', fatmaAvg),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AspectRatio(
                    aspectRatio: 1.7,
                    child: _buildComparativeChart(hagerAvg, fatmaAvg),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildDynamicAnalysis(overallAvg, avgDiff, hagerAvg, fatmaAvg),
            ),
          ),
        ],
      ),
    );
  }

  Color getColorFromPercentage(double value) {
    if (value >= 75) {
      return Colors.green;
    } else if (value >= 50) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  Widget _buildComparisonItem(String name, double avg) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          '${avg.toStringAsFixed(1)}%',
          style: TextStyle(
            fontSize: 24,
            color: getColorFromPercentage(avg),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDynamicAnalysis(double classAvg, double diff, double hagerAvg, double fatmaAvg) {
    String performanceGapText;
    String recommendationText;
    Color iconColor;

    if (diff >= 20) {
      performanceGapText = 'There is a significant performance gap between students.';
      recommendationText = 'Provide personalized support to the lower-performing student, and use group tasks to balance learning.';
      iconColor = Colors.red;
    } else if (diff >= 10) {
      performanceGapText = 'There is a moderate difference in focus between students.';
      recommendationText = 'Use collaborative activities to encourage balance and peer learning.';
      iconColor = Colors.orange;
    } else {
      performanceGapText = 'Students have similar levels of focus.';
      recommendationText = 'Maintain the current approach and encourage continuous engagement.';
      iconColor = Colors.green;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Class Analysis',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListTile(
          leading: Icon(Icons.insights, color: iconColor),
          title: Text(performanceGapText),
          subtitle: Text(
            'Hager: ${hagerAvg.toStringAsFixed(1)}%   •   Fatma: ${fatmaAvg.toStringAsFixed(1)}%',
          ),
        ),
        ListTile(
          leading: const Icon(Icons.analytics, color: Colors.blue),
          title: const Text('Class Average Focus'),
          subtitle: Text('${classAvg.toStringAsFixed(1)}%'),
        ),
        ListTile(
          leading: Icon(Icons.lightbulb, color: iconColor),
          title: const Text('Suggested Recommendation'),
          subtitle: Text(recommendationText),
        ),
      ],
    );
  }

  Widget _buildComparativeChart(double hagerAvg, double fatmaAvg) {
    final hagerColor = getColorFromPercentage(hagerAvg);
    final fatmaColor = getColorFromPercentage(fatmaAvg);

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text('${value.toInt()}%', style: const TextStyle(fontSize: 10)),
              reservedSize: 30,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                if (value.toInt() >= 0 && value.toInt() < hagerData.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      hagerData[value.toInt()]['time'].toString().split('-')[0],
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 30,
            ),
          ),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: true),
        minX: 0,
        maxX: hagerData.length - 1.0,
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: List.generate(
              hagerData.length,
                  (index) => FlSpot(index.toDouble(), hagerData[index]['focus'].toDouble()),
            ),
            isCurved: true,
            color: hagerColor,
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: hagerColor.withOpacity(0.1)),
          ),
          LineChartBarData(
            spots: List.generate(
              fatmaData.length,
                  (index) => FlSpot(index.toDouble(), fatmaData[index]['focus'].toDouble()),
            ),
            isCurved: true,
            color: fatmaColor,
            barWidth: 3,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: true, color: fatmaColor.withOpacity(0.1)),
          ),
        ],
      ),
    );
  }
}


