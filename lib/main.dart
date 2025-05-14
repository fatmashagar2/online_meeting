////////////////////////////////////////////////////////////////////////////////////
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:online_meeting/features/custom_button.dart';
import 'package:online_meeting/splash/presentation/view/splash_view.dart';
import 'package:provider/provider.dart';

//import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/themes/theme_provider.dart';
import 'features/auth/presentation/view/login_view.dart';
import 'features/custom_app_bar.dart';
import 'features/home/presentation/view/home_view.dart';
import 'features/profile/presentation/view_model/language_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_meeting/features/data_input_screen.dart';
import 'package:online_meeting/splash/presentation/view/splash_view.dart';
import 'package:provider/provider.dart';
import 'core/localization/app_localization.dart';
import 'core/themes/theme_provider.dart';
import 'features/StudentConcentrationReport.dart';
import 'features/auth/presentation/view/login_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

import 'features/home/presentation/view/home_view.dart';
import 'features/meeting_room/presentation/view/meeting_view.dart';
import 'features/notification/ConcentrationNotifications.dart';
import 'features/on_boarding/presentation/view/on_boarding_view.dart';
import 'features/profile/presentation/view_model/language_provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:async';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sha_fingerprint/flutter_sha_fingerprint.dart';

import 'features/with_ai/vedio_with_ai.dart';
import 'package:flutter/material.dart';

import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterShaFingerprint.getFingerprints();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? seenOnboarding = prefs.getBool('isFirstTime');

  // tz.initializeTimeZones(); // مهمة جدًا للتوقيتات
  final ScreenshotController globalScreenshotController =
      ScreenshotController();
  OneSignal.initialize(
    '5f739295-3d77-474b-9d82-ce02ec408f66', // حطي الـ App ID بتاع OneSignal
  );

  OneSignal.Notifications.requestPermission(true);
  await Firebase.initializeApp();
  OneSignal.User.addTagWithKey(
      "screen", "quiz"); // (لو حبيت تستخدم تارجتينج بالتاج)

  OneSignal.Notifications.addClickListener((event) {
    final additionalData = event.notification.additionalData;
    if (additionalData != null && additionalData['screen'] == 'quiz') {
      navigatorKey.currentState?.pushNamed('/quiz');
    }
  });
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // await requestNotificationPermission();
  // await saveDeviceToken(); // حفظ التوكن عند بدء التشغيل
  //
  //
  // // await NotificationService.init(); // ضروري
  // _setupTokenRefresh();

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ],
        child: Screenshot(
            controller: globalScreenshotController,
            child: MyApp(seenOnboarding: seenOnboarding ?? false))),
  );

//
//
}





// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'dart:math';
// import 'package:flutter/services.dart';
//
// void main() {
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.landscapeLeft,
//     DeviceOrientation.landscapeRight,
//   ]);
//
//   runApp(const MyApp(seenOnboarding: seenOnboarding ?? false));
// }


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  final bool seenOnboarding;

  const MyApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    // final languageProvider = Provider.of<LanguageProvider>(context);
    final ScreenshotController globalScreenshotController =
        ScreenshotController();

    return ScreenUtilInit(
      designSize: Size(375, 812),
      // Set the design size according to your design
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          // ربط الـ key هنا
          routes: {
            '/quiz': (context) => QuizScreen(),
            // باقي الراوتس
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          // themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          // locale: languageProvider.locale,
          supportedLocales: [Locale('en'), Locale('ar')],
          home: SplashView(

          ),
        );
      },
    );
  }
}


class CreateQuestionScreen extends StatefulWidget {
  @override
  _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
}

class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
  final _questionController = TextEditingController();
  final _optionsController = TextEditingController();
  final _correctAnswerController = TextEditingController();
  final _durationController = TextEditingController(); // ده الجديد

  List<Map<String, dynamic>> _questions = [];

  void _addQuestion() {
    final questionText = _questionController.text;
    final options =
        _optionsController.text.split(",").map((e) => e.trim()).toList();
    final correctAnswer = _correctAnswerController.text;

    if (questionText.isEmpty || options.length < 2 || correctAnswer.isEmpty) {
      _showErrorMessage('Please fill all fields correctly');
      return;
    }

    _questions.add({
      'questionText': questionText,
      'options': options,
      'correctAnswer': correctAnswer,
    });

    _clearQuestionFields();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Question added! You can add another one.'),
    ));
  }

  Future<void> _saveQuestions() async {
    if (_questionController.text.isNotEmpty &&
        _optionsController.text.isNotEmpty &&
        _correctAnswerController.text.isNotEmpty) {
      final questionText = _questionController.text;
      final options =
          _optionsController.text.split(",").map((e) => e.trim()).toList();
      final correctAnswer = _correctAnswerController.text;

      if (options.length < 2) {
        _showErrorMessage('Please provide at least two options.');
        return;
      }

      _questions.add({
        'questionText': questionText,
        'options': options,
        'correctAnswer': correctAnswer,
      });

      _clearQuestionFields();
    }

    if (_questions.isEmpty) {
      _showErrorMessage('Please add at least one question before saving.');
      return;
    }

    if (_durationController.text.isEmpty) {
      _showErrorMessage('Please enter the quiz duration.');
      return;
    }

    try {
      // نعمل مستند للكويز و نحفظ فيه الوقت وتاريخ الإنشاء
      final quizDoc =
          await FirebaseFirestore.instance.collection('quizzes').add({
        'duration': int.parse(_durationController.text),
        'createdAt': Timestamp.now(),
      });

      // نضيف الأسئلة جوه كوليكشن فرعي
      for (var question in _questions) {
        await quizDoc.collection('questions').add(question);
      }

      _questions.clear();
      _durationController.clear();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Quiz and questions saved successfully!'),
      ));

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ScheduleNotificationPage()));
    } catch (e) {
      _showErrorMessage('Error saving quiz: $e');
    }
  }

  Future<void> sendNotificationToAdmin({
    required String studentName,
  }) async {
    final String oneSignalAppId =
        "5f739295-3d77-474b-9d82-ce02ec408f66"; // معرف التطبيق
    final String oneSignalRestApiKey =
        "os_v2_app_l5zzffj5o5duxhmczyboyqepmz2c35tnvlxuaqf2ny3jzowd6ekexgoggbvvsmsmo556hoornbjc3xtq7yla6kzy7kf6bvqgfgju7oq"; // مفتاح API
    const String adminPlayerId =
        '88576ebd-162d-46da-8432-fbb3d04aad77'; // Player ID بتاع الإدمن

    final url = Uri.parse('https://onesignal.com/api/v1/notifications');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $oneSignalRestApiKey',
    };

    final body = jsonEncode({
      'app_id': oneSignalAppId,
      'include_player_ids': [adminPlayerId],
      'headings': {'ar': 'دخول طالب جديد', 'en': 'New Student Joined'},
      'contents': {'ar': '$studentName جاهز/ة', 'en': '$studentName is Ready'},
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Notification sent successfully to Admin');
      print('Response Body: ${response.body}');
    } else {
      print('Failed to send notification. Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }
  }

  void _clearQuestionFields() {
    _questionController.clear();
    _optionsController.clear();
    _correctAnswerController.clear();
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        txt: "Create Quiz",
        isIconVisible: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildTextField(_questionController, 'Enter question'),
            SizedBox(height: 10),
            _buildTextField(
                _optionsController, 'Enter options (comma separated)'),
            SizedBox(height: 10),
            _buildTextField(_correctAnswerController, 'Enter correct answer'),
            SizedBox(height: 20),
            _buildTextField(
                _durationController, 'Enter quiz duration (in minutes)'),
            SizedBox(height: 100),
            CustomButton(
              text: 'Add Question',
              w: 450,
              onPressed: _addQuestion,
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'Save All Questions',
              w: 450,
              onPressed: () async {
                await _saveQuestions(); // حفظ الأسئلة
                // إرسال إشعار بعد حفظ الأسئلة
                await sendNotificationToAdmin(studentName: 'Fatma Shagar');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType:
          label.contains('minutes') ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey[700],
          fontWeight: FontWeight.bold,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
    );
  }
}

// تخزين الوقت في Firestore
Future<void> storeNotificationTime(
    DateTime scheduledTime, String title, String body) async {
  final notificationData = {
    'scheduledAt': Timestamp.fromDate(scheduledTime),
    'title': title,
    'body': body,
    'sent': false, // لتحديد إذا تم إرسال الإشعار أم لا
  };

  // تخزين الإشعار في Firestore
  await FirebaseFirestore.instance
      .collection('scheduled_notifications')
      .add(notificationData);
}

// مراقبة الوقت وإرسال الإشعار باستخدام Timer
void checkScheduledNotifications() {
  Timer.periodic(Duration(seconds: 30), (timer) async {
    final now = DateTime.now();

    // التحقق من وجود إشعارات قد حان وقتها
    final snapshot = await FirebaseFirestore.instance
        .collection('scheduled_notifications')
        .where('scheduledAt', isLessThanOrEqualTo: now)
        .where('sent', isEqualTo: false)
        .get();

    for (var doc in snapshot.docs) {
      // استخراج البيانات من Firestore
      final notificationData = doc.data();

      // إرسال الإشعار عبر OneSignal
      sendNotificationToOneSignal(
          notificationData['title'], notificationData['body']);

      // تحديث حالة الإشعار ليتم إرسالها
      await doc.reference.update({'sent': true});
    }
  });
}

// إرسال الإشعار باستخدام OneSignal
Future<void> sendNotificationToOneSignal(String title, String body) async {
  final String oneSignalAppId =
      "5f739295-3d77-474b-9d82-ce02ec408f66"; // استبدلها بمعرف التطبيق الخاص بك
  final String oneSignalApiKey =
      "os_v2_app_l5zzffj5o5duxhmczyboyqepmz2c35tnvlxuaqf2ny3jzowd6ekexgoggbvvsmsmo556hoornbjc3xtq7yla6kzy7kf6bvqgfgju7oq"; // استبدلها بمفتاح API الخاص بك

  final response = await http
      .post(Uri.parse("https://onesignal.com/api/v1/notifications"), headers: {
    "Authorization": "Basic $oneSignalApiKey",
    "Content-Type": "application/json"
  }, body: '''
    {
      "app_id": "$oneSignalAppId",
      "headings": {"en": "$title"},
      "contents": {"en": "$body"},
       "included_segments": ["All"],
  
          "data": {
            "screen": "quiz"
          }
    ''');

  if (response.statusCode == 200) {
    print("Notification sent successfully");
  } else {
    print("Failed to send notification");
  }
}

// صفحة لاختيار الوقت والإشعار داخل التطبيق
class ScheduleNotificationPage extends StatefulWidget {
  @override
  _ScheduleNotificationPageState createState() =>
      _ScheduleNotificationPageState();
}

class _ScheduleNotificationPageState extends State<ScheduleNotificationPage> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  DateTime? scheduledDate;

  void _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(minutes: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now().replacing(
        minute: (TimeOfDay.now().minute + 1) % 60,
      ),
    );

    if (time == null) return;

    final fullDateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    setState(() {
      scheduledDate = fullDateTime;
    });
  }

  Future<void> sendNotificationToAdmin({
    required String studentName,
  }) async {
    final String oneSignalAppId =
        "5f739295-3d77-474b-9d82-ce02ec408f66"; // معرف التطبيق الخاص بك
    final String oneSignalRestApiKey =
        "os_v2_app_l5zzffj5o5duxhmczyboyqepmz2c35tnvlxuaqf2ny3jzowd6ekexgoggbvvsmsmo556hoornbjc3xtq7yla6kzy7kf6bvqgfgju7oq"; // مفتاح API الخاص بك
    const String adminPlayerId =
        '9b608cdc-e9ec-4817-8604-209e39b8fa67'; // Player ID الخاص بالإدمن

    final url = Uri.parse('https://onesignal.com/api/v1/notifications');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $oneSignalRestApiKey',
    };

    final body = jsonEncode({
      'app_id': oneSignalAppId,
      'include_player_ids': [adminPlayerId],
      'headings': {'ar': 'دخول طالب جديد', 'en': 'New Student Joined'},
      'contents': {'ar': '$studentName جاهز/ة', 'en': '$studentName is Ready'},
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Notification sent successfully to Admin');
    } else {
      print('Failed to send notification. Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }
  }

  Future<void> sendNotificationToOneSignal(String title, String body) async {
    final String oneSignalAppId =
        "5f739295-3d77-474b-9d82-ce02ec408f66"; // استبدلها بمعرف التطبيق الخاص بك
    final String oneSignalApiKey =
        "os_v2_app_l5zzffj5o5duxhmczyboyqepmz2c35tnvlxuaqf2ny3jzowd6ekexgoggbvvsmsmo556hoornbjc3xtq7yla6kzy7kf6bvqgfgju7oq"; // استبدلها بمفتاح API الخاص بك

    if (scheduledDate == null) {
      print("No scheduled date selected.");
      return;
    }

    final formattedDate = scheduledDate!.toUtc().toIso8601String();

    final response = await http.post(
        Uri.parse("https://onesignal.com/api/v1/notifications"),
        headers: {
          "Authorization": "Basic $oneSignalApiKey",
          "Content-Type": "application/json"
        },
        body: '''
  {
    "app_id": "$oneSignalAppId",
    "headings": {"en": "$title"},
    "contents": {"en": "$body"},
    "included_segments": ["All"],
    "send_after": "$formattedDate",
    "data": {
      "screen": "quiz"
    }
  }
  ''');

    if (response.statusCode == 200) {
      print("Notification scheduled successfully");
    } else {
      print("Failed to send notification: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = scheduledDate != null
        ? DateFormat('yyyy-MM-dd HH:mm').format(scheduledDate!)
        : 'Pick date & time';

    return Scaffold(
      appBar: CustomAppBar(txt: 'Schedule Notification', isIconVisible: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Notification Title',
                labelStyle: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: bodyController,
              decoration: InputDecoration(
                labelText: 'Notification body',
                labelStyle: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.topRight,
              child: TextButton.icon(
                onPressed: _pickDateTime,
                icon: Icon(
                  Icons.calendar_today,
                  color: Color(0xFF1E1F22),
                ),
                label: Text(
                  formattedDate,
                  style: TextStyle(color: Color(0xFF1E1F22)),
                ),
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
                text: 'Send',
                w: 320,
                onPressed: () async {
                  try {
                    final title = titleController.text;
                    final body = bodyController.text;

                    // لو العنوان والجسم مش فاضيين ابعت النوتيفيكيشن المجدول
                    if (title.isNotEmpty && body.isNotEmpty) {
                      await sendNotificationToOneSignal(title, body);
                    } else {
                      print(
                          "Please enter both title and body for the notification.");
                    }
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  } catch (e) {
                    print("Error occurred while sending notification: $e");
                  }
                })
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>
    with SingleTickerProviderStateMixin {
  Map<int, String?> _selectedOptions = {};
  List<DocumentSnapshot> _questions = [];
  Timer? _timer;
  int _remainingSeconds = 0;
  int _totalSeconds = 0;
  double progress = 1.0; // ✅ عرّفت المتغير هنا
  bool _submitted = false;
  bool _soundPlayed = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
    _sendStudentEntryNotification();
    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _pulseController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _pulseController.forward();
        }
      });

    _pulseAnimation = _pulseController.drive(Tween(begin: 1.0, end: 1.05));
  }

  Future<void> _sendStudentEntryNotification() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final studentName = user?.displayName ?? "طالب جديد";
      await sendNotificationToAdmin(studentName: studentName);
    } catch (e) {
      print("Error sending notification: $e");
    }
  }

  Future<void> sendNotificationToAdmin({required String studentName}) async {
    const String oneSignalAppId = "your-app-id";
    const String oneSignalRestApiKey = "your-api-key";
    const String adminPlayerId = 'your-player-id';

    try {
      final response = await http.post(
        Uri.parse('https://onesignal.com/api/v1/notifications'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Basic $oneSignalRestApiKey',
        },
        body: jsonEncode({
          'app_id': oneSignalAppId,
          'include_player_ids': [adminPlayerId],
          'headings': {'en': 'Student Ready', 'ar': 'طالب جاهز'},
          'contents': {
            'en': '$studentName is ready!',
            'ar': '$studentName جاهز/ة'
          },
        }),
      );

      print("Status Code: ${response.statusCode}");
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _fetchQuestions() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('quizzes')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final quizDoc = snapshot.docs.first;
      final questionsSnapshot =
          await quizDoc.reference.collection('questions').get();

      setState(() {
        _questions = questionsSnapshot.docs;
        _remainingSeconds = (quizDoc['duration'] ?? 1) * 60;
        _totalSeconds = _remainingSeconds;
      });

      _startTimer();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
          progress = _remainingSeconds / _totalSeconds;
        });

        if (_remainingSeconds == 30) {
          await _startSoundLoop(); // لما يوصل 30 ثانية، يبدأ تشغيل الصوت في لوب
        }
      } else {
        timer.cancel();
        _stopSound(); // لما يخلص الوقت نقفل الصوت
      }
    });
  }

  Future<void> _startSoundLoop() async {
    _audioPlayer.stop(); // تأكد إنه مفيش صوت شغال قبل كده
    _audioPlayer.setReleaseMode(ReleaseMode.loop); // خليه يعيد نفسه تلقائياً
    await _audioPlayer.play(AssetSource('x.mp3'));
  }

  void _stopSound() {
    _audioPlayer.stop(); // لما يخلص الاختبار أو التايمر يقف، نقفل الصوت
  }

  void _playSound() async {
    // استخدم AssetSource للإشارة إلى المسار داخل مجلد الأصول
    await _audioPlayer.play(AssetSource('x.mp3'));
  }

  void _submitAnswers() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _submitted = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pulseController.dispose();
    _audioPlayer.dispose(); // تأكد من التخلص من مشغل الصوت بعد الانتهاء
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Quiz')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    double progress = (_totalSeconds - _remainingSeconds) / _totalSeconds;
    Color progressColor = _remainingSeconds <= 30 ? Colors.red : Colors.green;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: CustomAppBar(txt: "Quiz", isIconVisible: false),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      color: progressColor,
                      minHeight: 12,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ScaleTransition(
                  scale: _remainingSeconds <= 5
                      ? _pulseAnimation
                      : AlwaysStoppedAnimation(1.0),
                  child: AnimatedDefaultTextStyle(
                    duration: Duration(milliseconds: 500),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: progressColor,
                    ),
                    child: Text(
                        'Time Remaining: ${_formatTime(_remainingSeconds)}'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                final questionData =
                    _questions[index].data() as Map<String, dynamic>;
                final questionText = questionData['questionText'];
                final options = List<String>.from(questionData['options']);
                final correctAnswer = questionData['correctAnswer'];
                final selected = _selectedOptions[index];

                bool isCorrect = selected == correctAnswer;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Q${index + 1}: $questionText",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              if (_submitted)
                                Icon(
                                  selected == null
                                      ? Icons.help_outline
                                      : isCorrect
                                          ? Icons.check_circle
                                          : Icons.cancel,
                                  color: selected == null
                                      ? Colors.grey
                                      : isCorrect
                                          ? Colors.green
                                          : Colors.red,
                                ),
                            ],
                          ),
                          SizedBox(height: 12),
                          ...options.map((option) {
                            return RadioListTile<String>(
                              activeColor: Colors.deepPurple,
                              title: Text(
                                option,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: _submitted
                                      ? option == correctAnswer
                                          ? Colors.green
                                          : option == selected
                                              ? Colors.red
                                              : Colors.black
                                      : Colors.black,
                                ),
                              ),
                              value: option,
                              groupValue: _selectedOptions[index],
                              onChanged: _submitted
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _selectedOptions[index] = value;
                                      });
                                    },
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1E1F22),
            minimumSize: Size(double.infinity, 50),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: _submitted ? null : _submitAnswers,
          child: Text(
            _submitted ? 'Quiz Submitted' : 'Submit Answers',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

////////////////////// test notication alerts     ////////

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
//

// import 'features/home/presentation/view/home_view.dart';  // تأكد من أنك تستخدم المكتبة الصحيحة


class JitsiMeetWebViewPage extends StatefulWidget {
  @override
  _JitsiMeetWebViewPageState createState() => _JitsiMeetWebViewPageState();
}

class _JitsiMeetWebViewPageState extends State<JitsiMeetWebViewPage> {
  late WebViewController _controller;
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late ScreenshotController _screenshotController;
  late CameraDescription _frontCamera;
  bool _isCameraReady = false;
  bool _isWebViewReady = false; // إضافة متغير لمتابعة حالة تهيئة WebView

  final String _serverUrl =
      "https://8x8.vc/vpaas-magic-cookie-cdc1bc8812454841af7f495cccd69fc6";
  final String _tenant = "EDU%20FOCUS";

  @override
  void initState() {
    super.initState();
    _screenshotController = ScreenshotController();
    requestPermissions();
    _initializeCamera();
    Future.delayed(Duration(seconds: 5), () {
      final roomUrl = _generateMeetingUrl();
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(roomUrl));
      setState(() {
        _isWebViewReady = true; // تأكيد تهيئة WebView
      });
    });
  }

  Future<void> requestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    PermissionStatus microphoneStatus = await Permission.microphone.request();

    if (cameraStatus.isGranted && microphoneStatus.isGranted) {
      print("Camera and Microphone permissions granted");
    } else {
      print(
          "Permissions denied. Please enable camera and microphone permissions.");
    }
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);

    _cameraController = CameraController(_frontCamera, ResolutionPreset.medium);
    await _cameraController.initialize();
    setState(() {
      _isCameraReady = true;
    });

    // Start capturing screenshots every 10 seconds
    Timer.periodic(Duration(seconds: 10), (timer) {
      _takeScreenshot();
    });
  }

  void _takeScreenshot() async {
    // Get the app's documents directory
    final directory = await getApplicationDocumentsDirectory();

    // Define the file path for the screenshot
    final filePath =
        '${directory.path}/screenshot_${DateTime.now().millisecondsSinceEpoch}.png';

    // Capture and save the screenshot
    await _screenshotController.captureAndSave(filePath);
    print("Screenshot saved at: $filePath");
  }

  String _generateRoomId() {
    return 'room'; // يمكن تعديلها لتكون ديناميكية إذا رغبت
  }

  String _generateMeetingUrl() {
    final roomId = _generateRoomId();
    final fullUrl = '$_serverUrl/$_tenant';
    return fullUrl;
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jitsi Meet'),
      ),
      body: _isCameraReady && _isWebViewReady // التأكد من أن WebView جاهز
          ? Stack(
              children: [
                CameraPreview(_cameraController),
                WebViewWidget(controller: _controller),
              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

// // Align(
// // alignment: Alignment(0, .99),
// // // 0 أفقي (وسط)، 0.99 عمودي (قريبة من تحت)
// // child: FloatingActionButton(
// // onPressed: ,
// // child: Icon(Icons.screen_share),
// // tooltip: 'مشاركة الشاشة',
// // ),
// // ),

// class ScreenshotPage extends StatefulWidget {
//   @override
//   _ScreenshotPageState createState() => _ScreenshotPageState();
// }
//
// class _ScreenshotPageState extends State<ScreenshotPage> {
//   final ScreenshotController _screenshotController = ScreenshotController();
//   late Timer _timer;
//
//   @override
//   void initState() {
//     super.initState();
//     _requestPermission();
//     _timer = Timer.periodic(Duration(seconds: 600), _captureScreenshot);
//   }
//
//   Future<void> _requestPermission() async {
//     await [
//       Permission.storage,
//       Permission.manageExternalStorage, // للأندرويد 11 وما فوق
//     ].request();
//   }
//
//   Future<void> _captureScreenshot(Timer timer) async {
//     final image = await _screenshotController.capture();
//
//     if (image != null) {
//       final directory = await getExternalStorageDirectory();
//       final screenshotsFolder = Directory("${directory!.path}/Pictures/screenshots_flutter");
//       if (!await screenshotsFolder.exists()) {
//         await screenshotsFolder.create(recursive: true);
//       }
//
//       final fileName = "screenshot_${DateTime.now().millisecondsSinceEpoch}.png";
//       final filePath = "${screenshotsFolder.path}/$fileName";
//       final file = File(filePath);
//
//       await file.writeAsBytes(image);
//
//       print("✅ تم حفظ الصورة في: $filePath");
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("📸 تم حفظ الصورة في ملفات الموبايل")),
//       );
//     } else {
//       print("❌ فشل في التقاط الصورة");
//     }
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Screenshot كل 5 ثواني")),
//       body: Screenshot(
//         controller: _screenshotController,
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.camera_alt, size: 70, color: Colors.blue),
//               SizedBox(height: 20),
//               Text("📸 يتم حفظ صورة كل 5 ثواني في مجلد الملفات"),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ImageListPage()),
//                   );
//                 },
//                 child: Text("عرض الصور الملتقطة"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ImageListPage extends StatelessWidget {
//   Future<List<File>> _getImages() async {
//     final directory = await getExternalStorageDirectory();
//     final screenshotsFolder = Directory("${directory!.path}/Pictures/screenshots_flutter");
//
//     if (!await screenshotsFolder.exists()) {
//       return [];
//     }
//
//     final files = screenshotsFolder.listSync();
//     return files.whereType<File>().toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("الصور الملتقطة")),
//       body: FutureBuilder<List<File>>(
//         future: _getImages(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//
//           if (snapshot.hasError) {
//             return Center(child: Text('حدث خطأ!'));
//           }
//
//           final images = snapshot.data ?? [];
//
//           if (images.isEmpty) {
//             return Center(child: Text('لا توجد صور بعد.'));
//           }
//
//           return ListView.builder(
//             itemCount: images.length,
//             itemBuilder: (context, index) {
//               final image = images[index];
//               return CircleAvatar(
//                 radius:150,
//                 child: Image.file(image),
//
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//

class QuizResultScreen extends StatelessWidget {
  final int correctCount;
  final int totalQuestions;

  const QuizResultScreen(
      {required this.correctCount, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    double scorePercent = correctCount / totalQuestions;
    String message = scorePercent >= 0.7 ? 'Bravo!' : 'Try Again!';

    return Scaffold(
      appBar: CustomAppBar(txt: "Quiz Result", isIconVisible: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: correctCount.toDouble()),
              duration: Duration(seconds: 2),
              builder: (context, double value, child) {
                return Text(
                  'Score: ${value.toInt()} / $totalQuestions',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              message,
              style: TextStyle(fontSize: 28, color: Colors.blue),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Replay يعني يرجع للشاشة اللي فاتت
              },
              child: Text('Replay Quiz'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .popUntil((route) => route.isFirst); // Exit to main screen
              },
              child: Text('Exit'),
            ),
          ],
        ),
      ),
    );
  }
}



// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   const AndroidInitializationSettings initializationSettingsAndroid =
//   AndroidInitializationSettings('@mipmap/ic_launcher');
//
//   final InitializationSettings initializationSettings =
//   InitializationSettings(android: initializationSettingsAndroid);
//
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: UploadVideoScreen(),
//     );
//   }
// }
