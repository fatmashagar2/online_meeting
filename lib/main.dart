// //////////////////////////////////////////////////////////////////////////////////////
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:online_meeting/features/custom_button.dart';
// import 'package:online_meeting/splash/presentation/view/splash_view.dart';
// import 'package:provider/provider.dart';
// //import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
// import 'package:uuid/uuid.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:path/path.dart' as path;
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uuid/uuid.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// import 'core/themes/theme_provider.dart';
// import 'features/auth/presentation/view/login_view.dart';
// import 'features/custom_app_bar.dart';
// import 'features/home/presentation/view/home_view.dart';
// import 'features/profile/presentation/view_model/language_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'dart:async';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:online_meeting/features/data_input_screen.dart';
// import 'package:online_meeting/splash/presentation/view/splash_view.dart';
// import 'package:provider/provider.dart';
// import 'core/localization/app_localization.dart';
// import 'core/themes/theme_provider.dart';
// import 'features/StudentConcentrationReport.dart';
// import 'features/auth/presentation/view/login_view.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter/material.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:convert';
//
// import 'features/home/presentation/view/home_view.dart';
// import 'features/meeting_room/presentation/view/meeting_view.dart';
// import 'features/notification/ConcentrationNotifications.dart';
// import 'features/on_boarding/presentation/view/on_boarding_view.dart';
// import 'features/profile/presentation/view_model/language_provider.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'package:provider/provider.dart';
//
// import 'package:flutter/material.dart';
//
// import 'package:firebase_core/firebase_core.dart';
//
// import 'package:provider/provider.dart';
//
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   // tz.initializeTimeZones(); // مهمة جدًا للتوقيتات
// //   //
// //    await Firebase.initializeApp();
// //   // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
// //   //
// //   // await requestNotificationPermission();
// //   // await saveDeviceToken(); // حفظ التوكن عند بدء التشغيل
// //   //
// //   //
// //   // // await NotificationService.init(); // ضروري
// //   // _setupTokenRefresh();
// //
// //   runApp(
// //     MultiProvider(
// //       providers: [
// //         ChangeNotifierProvider(create: (context) => ThemeProvider()),
// //         ChangeNotifierProvider(create: (context) => LanguageProvider()),
// //       ],
// //       child: MyApp(),
// //     ),
// //   );
// //
// // //
// // //
// //  }
//
//
// ////////////////////////////////////////////////////////////////////////
// //
//
// // class NotificationService {
// //   static Future<void> sendNotificationToAll(String title, String body) async {
// //     // Get all device tokens from Firestore
// //     final tokensSnapshot = await FirebaseFirestore.instance.collection('device_tokens').get();
// //
// //     // Get the tokens
// //     //final List<String> tokens = tokensSnapshot.docs.map((doc) => doc['token'] as String).toList();
// // String token="f6BsY2crT8yFT8R4GiVDlG:APA91bGnfEjKAxAEdO1D_MOkERqY-iWE7fY-cfK7_eFMfEwUtY0r3y6IAp2T2gmYJNzyP1ncWRLiLL5U-GdERpCzb1SwfHcqklGJQX1yC6cdjOEGf7VcWnc";
// //     if (token.isEmpty) {
// //       print("No tokens available to send notifications.");
// //       return;
// //     }
// //
// //     // Prepare the payload
// //     final message = {
// //       'registration_ids': token,  // Array of device tokens
// //       'notification': {
// //         'title': title,
// //         'body': body,
// //       },
// //     };
// //
// //     try {
// //       final response = await http.post(
// //         Uri.parse("https://fcm.googleapis.com/v1/projects/metting-96269/messages:send"),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer f6BsY2crT8yFT8R4GiVDlG:APA91bGnfEjKAxAEdO1D_MOkERqY-iWE7fY-cfK7_eFMfEwUtY0r3y6IAp2T2gmYJNzyP1ncWRLiLL5U-GdERpCzb1SwfHcqklGJQX1yC6cdjOEGf7VcWnc',  // Replace with your FCM server key
// //         },
// //         body: jsonEncode(message),
// //       );
// //
// //       if (response.statusCode == 200) {
// //         print("Notification sent successfully to all users");
// //       } else {
// //         print("Failed to send notification: ${response.body}");
// //       }
// //     } catch (e) {
// //       print("Error sending notification: $e");
// //     }
// //   }
// //
// //   Future<void> sendNotificationToDevice(String token, String title, String body) async {
// //     final String accessToken = 'YOUR_OAUTH_ACCESS_TOKEN'; // OAuth2 token هنا
// //
// //     final message = {
// //       "message": {
// //         "token": token,
// //         "notification": {
// //           "title": title,
// //           "body": body,
// //         }
// //       }
// //     };
// //
// //     try {
// //       final response = await http.post(
// //         Uri.parse("https://fcm.googleapis.com/v1/projects/metting-96269messages:send"),
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Authorization': 'Bearer $accessToken',
// //         },
// //         body: jsonEncode(message),
// //       );
// //
// //       if (response.statusCode == 200) {
// //         print("Notification sent successfully");
// //       } else {
// //         print("Failed to send notification: ${response.body}");
// //       }
// //     } catch (e) {
// //       print("Error sending notification: $e");
// //     }
// //   }
// //
// //
// // }
// //
// // void _setupTokenRefresh() {
// //   FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
// //     await FirebaseFirestore.instance.collection('tokens').doc(newToken).set({
// //       'token': newToken,
// //       'updatedAt': FieldValue.serverTimestamp(),
// //     });
// //   });
// // }
// // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// //   await Firebase.initializeApp();
// //   print('Handling background message: ${message.messageId}');
// //
// //   if (message.data['route'] == 'serviceScreen') {
// //     // استخدم Router هنا
// //     print('Redirect to service screen');
// //   }
// // }
// //
// // Future<void> requestNotificationPermission() async {
// //   if (await Permission.notification.isDenied) {
// //     await Permission.notification.request();
// //   }
// // }
// // Future<void> saveDeviceToken() async {
// //   String? token = await FirebaseMessaging.instance.getToken();
// //   if (token != null) {
// //     await FirebaseFirestore.instance.collection('tokens').doc(token).set({
// //       'token': token,
// //       'createdAt': FieldValue.serverTimestamp(),
// //     });
// //   }
// // }
// //
// //
//
//
// //
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // //
// // // void main() => runApp(const MyApp());
// // //
// // //
// // //
// // //
// // //
// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       home: MeetingPage(),
// // //     );
// // //   }
// // // }
// // //
// // // class MeetingPage extends StatefulWidget {
// // //   const MeetingPage({super.key});
// // //
// // //   @override
// // //   State<MeetingPage> createState() => _MeetingPageState();
// // // }
// // //
// // // class _MeetingPageState extends State<MeetingPage> {
// // //   late final RtcEngine _agoraEngine;
// // //   final String _appId = "1d51a9a0f2b14b5783442d3a36a52f61";
// // //   final String _channelName = "testChannel";
// // //   final List<int> _remoteUids = [];
// // //   bool _isJoined = false;
// // //   bool _isMuted = false;
// // //   bool _isVideoOn = true;
// // //   bool _isSharingScreen = false;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _initializeAgora();
// // //   }
// // //
// // //   Future<void> _initializeAgora() async {
// // //     await [
// // //       Permission.microphone,
// // //       Permission.camera,
// // //       Permission.systemAlertWindow,
// // //       Permission.bluetooth,
// // //       Permission.bluetoothConnect,
// // //     ].request();
// // //
// // //     _agoraEngine = createAgoraRtcEngine();
// // //     await _agoraEngine.initialize(RtcEngineContext(appId: _appId));
// // //
// // //     await _agoraEngine.setChannelProfile(
// // //         ChannelProfileType.channelProfileCommunication);
// // //     await _agoraEngine.enableVideo();
// // //     await _agoraEngine.startPreview();
// // //
// // //     _setupEventHandlers();
// // //   }
// // //
// // //   void _setupEventHandlers() {
// // //     _agoraEngine.registerEventHandler(
// // //       RtcEngineEventHandler(
// // //         onJoinChannelSuccess: (RtcConnection conn, int elapsed) {
// // //           setState(() => _isJoined = true);
// // //         },
// // //         onUserJoined: (RtcConnection conn, int uid, int elapsed) {
// // //           if (!_remoteUids.contains(uid)) {
// // //             setState(() => _remoteUids.add(uid));
// // //           }
// // //         },
// // //         onUserOffline: (RtcConnection conn, int uid, UserOfflineReasonType reason) {
// // //           setState(() => _remoteUids.remove(uid));
// // //         },
// // //         onLocalVideoStateChanged: (
// // //             VideoSourceType source,
// // //             LocalVideoStreamState state,
// // //             LocalVideoStreamReason reason,
// // //             ) {
// // //           if (source == VideoSourceType.videoSourceScreen) {
// // //             setState(() {
// // //               _isSharingScreen = state == LocalVideoStreamState.localVideoStreamStateCapturing;
// // //             });
// // //           }
// // //         },
// // //       ),
// // //     );
// // //   }
// // //
// // //   Future<void> _joinChannel() async {
// // //     try {
// // //       await _agoraEngine.joinChannel(
// // //           token: "007eJxTYDiu7rdtxtZ3CdfLpIrNvea3puT+e/9lds3cSjO2hHeTbgsqMJiYJRsZGCaaGVmaGZtYmKYmGhimpqaZm5onm5knGRgnZyZ8SG8IZGSI0WtjYWSAQBCfm6EktbjEOSMxLy81h4EBAJIzIvI=",
// // //         channelId: _channelName,
// // //         uid: 0,
// // //         options: const ChannelMediaOptions(
// // //           channelProfile: ChannelProfileType.channelProfileCommunication,
// // //           clientRoleType: ClientRoleType.clientRoleBroadcaster,
// // //           publishCameraTrack: true,
// // //           publishScreenTrack: false,
// // //         ),
// // //       );
// // //     } catch (e) {
// // //       print("Join error: $e");
// // //     }
// // //   }
// // //
// // //   Future<void> _leaveChannel() async {
// // //     await _agoraEngine.leaveChannel();
// // //     setState(() {
// // //       _isJoined = false;
// // //       _remoteUids.clear();
// // //     });
// // //   }
// // //
// // //   void _toggleMic() {
// // //     _agoraEngine.muteLocalAudioStream(!_isMuted);
// // //     setState(() => _isMuted = !_isMuted);
// // //   }
// // //
// // //   void _toggleCamera() {
// // //     _agoraEngine.muteLocalVideoStream(!_isVideoOn);
// // //     setState(() => _isVideoOn = !_isVideoOn);
// // //   }
// // //
// // //   Future<void> _toggleScreenSharing() async {
// // //     try {
// // //       if (!_isSharingScreen) {
// // //         await _agoraEngine.startScreenCapture(
// // //           const ScreenCaptureParameters2(
// // //             captureAudio: true,
// // //             captureVideo: true,
// // //             videoParams: ScreenVideoParameters(
// // //               dimensions: VideoDimensions(width: 1280, height: 720),
// // //             ),
// // //           ),
// // //         );
// // //         await _agoraEngine.updateChannelMediaOptions(
// // //           ChannelMediaOptions(
// // //             publishCameraTrack: false,
// // //             publishScreenTrack: true,
// // //           ),
// // //         );
// // //       } else {
// // //         await _agoraEngine.stopScreenCapture();
// // //         await _agoraEngine.updateChannelMediaOptions(
// // //           ChannelMediaOptions(
// // //             publishCameraTrack: true,
// // //             publishScreenTrack: false,
// // //           ),
// // //         );
// // //       }
// // //       setState(() => _isSharingScreen = !_isSharingScreen);
// // //     } catch (e) {
// // //       print("Screen sharing error: $e");
// // //     }
// // //   }
// // //
// // //   Widget _buildMainScreen() {
// // //     return Container(
// // //       color: Colors.black,
// // //       child: _isSharingScreen
// // //           ? AgoraVideoView(
// // //         controller: VideoViewController(
// // //           rtcEngine: _agoraEngine,
// // //           canvas: const VideoCanvas(uid: 0),
// // //           // استبدل بالباراميتر الصحيح إذا لزم الأمر
// // //           // sourceType: VideoSourceType.videoSourceScreen,
// // //         ),
// // //       )
// // //           : AgoraVideoView(
// // //         controller: VideoViewController(
// // //           rtcEngine: _agoraEngine,
// // //           canvas: const VideoCanvas(uid: 0),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildParticipantsGrid() {
// // //     return Container(
// // //       width: 150,
// // //       height: 200,
// // //       decoration: BoxDecoration(
// // //         color: Colors.black.withOpacity(0.3),
// // //         borderRadius: BorderRadius.circular(12),
// // //       ),
// // //       child: GridView.builder(
// // //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //           crossAxisCount: 1,
// // //           childAspectRatio: 0.8,
// // //         ),
// // //         itemCount: _remoteUids.length + 1,
// // //         itemBuilder: (context, index) {
// // //           if (index == 0) return _buildLocalPreview();
// // //           return _remoteVideo(_remoteUids[index - 1]);
// // //         },
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildLocalPreview() {
// // //     return Padding(
// // //       padding: const EdgeInsets.all(4.0),
// // //       child: ClipRRect(
// // //         borderRadius: BorderRadius.circular(8),
// // //         child: AgoraVideoView(
// // //           controller: VideoViewController(
// // //             rtcEngine: _agoraEngine,
// // //             canvas: const VideoCanvas(uid: 0),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _remoteVideo(int uid) {
// // //     return Padding(
// // //       padding: const EdgeInsets.all(4.0),
// // //       child: ClipRRect(
// // //         borderRadius: BorderRadius.circular(8),
// // //         child: AgoraVideoView(
// // //           controller: VideoViewController.remote(
// // //             rtcEngine: _agoraEngine,
// // //             canvas: VideoCanvas(uid: uid),
// // //             connection: RtcConnection(channelId: _channelName),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildWaitingScreen() {
// // //     return const Center(
// // //       child: Column(
// // //         mainAxisAlignment: MainAxisAlignment.center,
// // //         children: [
// // //           Icon(Icons.videocam_off, size: 80, color: Colors.grey),
// // //           SizedBox(height: 20),
// // //           Text('انضم إلى الاجتماع الآن', style: TextStyle(fontSize: 18)),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildControlBar() {
// // //     return Container(
// // //       padding: const EdgeInsets.symmetric(vertical: 20),
// // //       color: Colors.black.withOpacity(0.1),
// // //       child: Row(
// // //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //         children: [
// // //           IconButton(
// // //             icon: Icon(_isMuted ? Icons.mic_off : Icons.mic, size: 32),
// // //             color: _isMuted ? Colors.red : Colors.blue,
// // //             onPressed: _toggleMic,
// // //           ),
// // //           IconButton(
// // //             icon: Icon(_isVideoOn ? Icons.videocam : Icons.videocam_off, size: 32),
// // //             color: _isVideoOn ? Colors.blue : Colors.red,
// // //             onPressed: _toggleCamera,
// // //           ),
// // //           IconButton(
// // //             icon: Icon(
// // //               _isSharingScreen ? Icons.stop_screen_share : Icons.screen_share,
// // //               size: 32,
// // //             ),
// // //             color: _isSharingScreen ? Colors.green : Colors.grey,
// // //             onPressed: _toggleScreenSharing,
// // //           ),
// // //           ElevatedButton.icon(
// // //             icon: const Icon(Icons.logout),
// // //             label: Text(_isJoined ? 'مغادرة' : 'انضمام'),
// // //             style: ElevatedButton.styleFrom(
// // //               backgroundColor: _isJoined ? Colors.red : Colors.green,
// // //               foregroundColor: Colors.white,
// // //             ),
// // //             onPressed: _isJoined ? _leaveChannel : _joinChannel,
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('اجتماع Agora'),
// // //         centerTitle: true,
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           Expanded(
// // //             child: _isJoined
// // //                 ? Stack(
// // //               children: [
// // //                 _buildMainScreen(),
// // //                 Positioned(
// // //                   top: 20,
// // //                   right: 20,
// // //                   child: _buildParticipantsGrid(),
// // //                 ),
// // //               ],
// // //             )
// // //                 : _buildWaitingScreen(),
// // //           ),
// // //           _buildControlBar(),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // //
// // //   @override
// // //   void dispose() {
// // //     _agoraEngine.release();
// // //     super.dispose();
// // //   }
// // // }
// //
// //
// // // void main() async {
// // //   WidgetsFlutterBinding.ensureInitialized();
// // //   await Firebase.initializeApp();
// // //   runApp(const MyApp());
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(debugShowCheckedModeBanner: false, home: LoginView());
// // //   }
// // // }
// //
// // // class MeetingPage extends StatefulWidget {
// // //   const MeetingPage({super.key});
// // //
// // //   @override
// // //   State<MeetingPage> createState() => _MeetingPageState();
// // // }
// // //
// // // class _MeetingPageState extends State<MeetingPage> {
// // //   final TextEditingController _conferenceIdController = TextEditingController();
// // //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// // //
// // //   Future<void> _joinConference({required bool isCreating}) async {
// // //     final String conferenceId = isCreating
// // //         ? const Uuid().v4().substring(0, 8)
// // //         : _conferenceIdController.text.trim();
// // //
// // //     if (!isCreating && conferenceId.isEmpty) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text("Please enter a Conference ID to join")),
// // //       );
// // //       return;
// // //     }
// // //
// // //     if (isCreating) {
// // //       await _firestore.collection("meetings").doc(conferenceId).set({
// // //         "createdAt": Timestamp.now(),
// // //       });
// // //     } else {
// // //       final doc = await _firestore.collection("meetings").doc(conferenceId).get();
// // //       if (!doc.exists) {
// // //         ScaffoldMessenger.of(context).showSnackBar(
// // //           const SnackBar(content: Text("Meeting ID does not exist")),
// // //         );
// // //         return;
// // //       }
// // //     }
// // //
// // //     final String userId = const Uuid().v4().substring(0, 6);
// // //     final String userName = "User_$userId";
// // //
// // //     Navigator.push(
// // //       context,
// // //       MaterialPageRoute(
// // //         builder: (context) => VedoiConfernce(
// // //           confernceID: conferenceId,
// // //           userID: userId,
// // //           userName: userName,
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: const Text("Create / Join Meeting")),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           children: [
// // //             TextField(
// // //               controller: _conferenceIdController,
// // //               decoration: const InputDecoration(
// // //                 labelText: 'Conference ID (for Join only)',
// // //                 border: OutlineInputBorder(),
// // //               ),
// // //             ),
// // //             const SizedBox(height: 20),
// // //             Row(
// // //               children: [
// // //                 Expanded(
// // //                   child: ElevatedButton(
// // //                     onPressed: () => _joinConference(isCreating: true),
// // //                     child: const Text("Create Meeting"),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(width: 10),
// // //                 Expanded(
// // //                   child: ElevatedButton(
// // //                     onPressed: () => _joinConference(isCreating: false),
// // //                     child: const Text("Join Meeting"),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // // class VedoiConfernce extends StatelessWidget {
// // //   final String confernceID;
// // //   final String userID;
// // //   final String userName;
// // //
// // //   const VedoiConfernce({
// // //     super.key,
// // //     required this.confernceID,
// // //     required this.userID,
// // //     required this.userName,
// // //   });
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return SafeArea(
// // //       child: ZegoUIKitPrebuiltVideoConference(
// // //         appID: 1823359901,
// // //         appSign:
// // //         'f19b83ba31160e666d62cad5a6d6e2272126ed6699313a7eeedc5916fd721a77',
// // //         conferenceID: confernceID,
// // //         userID: userID,
// // //         userName: userName,
// // //         config: ZegoUIKitPrebuiltVideoConferenceConfig(),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// //
// //
// // // import 'package:flutter/material.dart';
// // //
// // // import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// // // import 'dart:math';
// // // import 'dart:math';
// // // import 'package:flutter/material.dart';
// // // import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// // //
// // // import 'package:flutter/material.dart';
// // //
// // // import 'dart:math';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// // // import 'dart:math';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// // // import 'dart:math';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// // // import 'dart:math';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// // // import 'dart:math';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// // // import 'dart:math';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// // // import 'dart:math';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// // // import 'dart:math';
// // //
// // // // void main() => runApp(const MaterialApp(home: SplashView(),));
// // //
// // // class MyApp extends StatefulWidget {
// // //   const MyApp({super.key});
// // //
// // //   @override
// // //   State<MyApp> createState() => _MyAppState();
// // // }
// // //
// // // class _MyAppState extends State<MyApp> {
// // //   final JitsiMeet _jitsiMeet = JitsiMeet();
// // //   final String _serverUrl = "https://8x8.vc/vpaas-magic-cookie-99476734cde9462aa129ec8010493317";
// // //   final String _tenant = "EDU%20FOCUS";
// // //
// // //   String _generateRoomId() {
// // //     return 'room_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999)}';
// // //   }
// // //
// // //   Future<void> _startMeeting() async {
// // //     try {
// // //       final roomId = _generateRoomId();
// // //       final options = JitsiMeetConferenceOptions(
// // //         serverURL: _serverUrl,
// // //         room: "$_tenant/$roomId",
// // //         configOverrides: {
// // //           "startWithAudioMuted": true,
// // //           "startWithVideoMuted": true,
// // //           "prejoinPageEnabled": false,
// // //         },
// // //         featureFlags: {
// // //           "welcomePage.enabled": false,
// // //           "resolution": 360,
// // //         },
// // //         userInfo: JitsiMeetUserInfo(
// // //           displayName: "فاطمه (مشرفة)",
// // //           email: "fatmashagar64@gmail.com",
// // //         ),
// // //       );
// // //
// // //       final listener = JitsiMeetEventListener(
// // //         conferenceJoined: (String url) {
// // //           debugPrint("✅ تم الانضمام إلى الاجتماع: $url");
// // //         },
// // //
// // //
// // //         conferenceTerminated: (String url, Object? error) {
// // //           debugPrint("⛔ انتهى الاجتماع: $url");
// // //           return null;
// // //         },
// // //         participantJoined: (email, name, role, participantId) {
// // //           debugPrint("👤 انضم: $name");
// // //           return null;
// // //         },
// // //       );
// // //
// // //       await _jitsiMeet.join(options, listener);
// // //     } catch (e) {
// // //       debugPrint("🔥 خطأ عام: ${e.toString()}");
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       home: Scaffold(
// // //         appBar: AppBar(
// // //           title: const Text('منصة التعليم'),
// // //           backgroundColor: Colors.blue.shade800,
// // //         ),
// // //         body: Center(
// // //           child: ElevatedButton(
// // //             onPressed: _startMeeting,
// // //             child: const Text("ابدأ الاجتماع"),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // // class NotificationService {
// // //   static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
// // //
// // //   static Future<void> init() async {
// // //     // تحديد إعدادات FCM
// // //     NotificationSettings settings = await _firebaseMessaging.requestPermission(
// // //       alert: true,
// // //       badge: true,
// // //       sound: true,
// // //     );
// // //
// // //     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
// // //       print('FCM Notifications are enabled');
// // //     } else {
// // //       print('FCM Notifications are not authorized');
// // //     }
// // //   }
// // //
// // //   static Future<void> sendNotification(String title, String body) async {
// // //     // إرسال إشعار باستخدام FCM
// // //     try {
// // //       await _firebaseMessaging.subscribeToTopic('all');
// // //       // يمكنك إرسال إشعار باستخدام FCM API الخاصة بك من هنا (Backend).
// // //       // ولكن في حالة أنك تريد إرسال إشعار مباشرة من التطبيق
// // //       // ستحتاج إلى استخدام API server-side لـ FCM.
// // //
// // //       // مثال على طلب HTTP (يمكنك استدعاء خادمك الخاص لإرسال إشعار FCM)
// // //     } catch (e) {
// // //       print('Failed to send notification: $e');
// // //     }
// // //   }
// // //
// // //   static Future<void> showNotification(String title, String body) async {
// // //     // FCM يقوم بتوصيل الإشعار تلقائيًا عبر التطبيق.
// // //     // لتفعيل الإشعارات محليًا باستخدام FCM، يمكن استخدام Push notifications مباشرة.
// // //   }
// // // }
// //
// //
// //
// // class OpenQuestionsScreen extends StatefulWidget {
// //   @override
// //   _OpenQuestionsScreenState createState() => _OpenQuestionsScreenState();
// // }
// //
// // class _OpenQuestionsScreenState extends State<OpenQuestionsScreen> {
// //   final _answers = {};
// //
// //   void _submitAnswers() {
// //     // هنا يمكن إرسال الإجابات إلى Firebase أو حفظها بطريقة أخرى
// //     print('Answers submitted: $_answers');
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Open Questions'),
// //       ),
// //       body: FutureBuilder(
// //         future: FirebaseFirestore.instance.collection('questionnaire').get(),
// //         builder: (context, snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: CircularProgressIndicator());
// //           }
// //
// //           final questions = snapshot.data!.docs;
// //
// //           return ListView.builder(
// //             itemCount: questions.length,
// //             itemBuilder: (context, index) {
// //               final questionData = questions[index];
// //               final questionText = questionData['questionText'];
// //               final options = List<String>.from(questionData['options']);
// //               final questionId = questionData.id;
// //
// //               return Card(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(questionText, style: TextStyle(fontSize: 18)),
// //                       ...options.map((option) {
// //                         return RadioListTile(
// //                           title: Text(option),
// //                           value: option,
// //                           groupValue: _answers[questionId],
// //                           onChanged: (value) {
// //                             setState(() {
// //                               _answers[questionId] = value;
// //                             });
// //                           },
// //                         );
// //                       }).toList(),
// //                     ],
// //                   ),
// //                 ),
// //               );
// //             },
// //           );
// //         },
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: _submitAnswers,
// //         child: Icon(Icons.send),
// //       ),
// //     );
// //   }
// // }
//
// // import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:onesignal_flutter/onesignal_flutter.dart';
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //
// //   OneSignal.initialize(
// //     '5f739295-3d77-474b-9d82-ce02ec408f66', // حطي الـ App ID بتاع OneSignal
// //   );
// //
// //   OneSignal.Notifications.requestPermission(true);
// //
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'OneSignal Demo',
// //       home: HomeScreen(),
// //     );
// //   }
// // }
// //
// // class HomeScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('OneSignal Notification')),
// //       body: Center(child: Text('مرحبا!')),
// //     );
// //   }
// // }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// // import 'package:firebase_messaging/firebase_messaging.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:online_meeting/splash/presentation/view/splash_view.dart';
// // import 'package:provider/provider.dart';
// // //import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
// // import 'package:uuid/uuid.dart';
//  import 'package:firebase_core/firebase_core.dart';
//
// void main()async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // tz.initializeTimeZones(); // مهمة جدًا للتوقيتات
//   //
//    await Firebase.initializeApp();
//
//   runApp(MyApp());
//   checkScheduledNotifications(); // تبدأ مراقبة الوقت عند فتح التطبيق
// }
//
// // import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:file_picker/file_picker.dart';
// // import 'dart:io';
//
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: UploadVideoScreen(),
// //     );
// //   }
// // }
// //
// // class UploadVideoScreen extends StatefulWidget {
// //   @override
// //   _UploadVideoScreenState createState() => _UploadVideoScreenState();
// // }
// //
// // class _UploadVideoScreenState extends State<UploadVideoScreen> {
// //   bool isUploading = false;
// //
// //   Future<void> pickAndUploadVideo() async {
// //     final result = await FilePicker.platform.pickFiles(type: FileType.video);
// //
// //     if (result != null && result.files.single.path != null) {
// //       File file = File(result.files.single.path!);
// //       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
// //
// //       setState(() {
// //         isUploading = true;
// //       });
// //
// //       try {
// //         // رفع الفيديو
// //         final ref = FirebaseStorage.instance.ref().child('videos/$fileName.mp4');
// //         UploadTask uploadTask = ref.putFile(file);
// //
// //         // انتظر الرفع
// //         final snapshot = await uploadTask.whenComplete(() => null);
// //
// //         if (snapshot.state == TaskState.success) {
// //           // الحصول على رابط التحميل
// //           String downloadUrl = await ref.getDownloadURL();
// //
// //           // حفظ الرابط في Realtime Database
// //           final dbRef = FirebaseDatabase.instance.ref('video_link');
// //           await dbRef.set(downloadUrl);
// //
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(content: Text("✅ Video uploaded and URL saved")),
// //           );
// //         } else {
// //           throw Exception("Upload failed: ${snapshot.state}");
// //         }
// //       } catch (e) {
// //         print("❌ Error: $e");
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text("❌ Upload failed")),
// //         );
// //       }
// //
// //       setState(() {
// //         isUploading = false;
// //       });
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Upload Video")),
// //       body: Center(
// //         child: isUploading
// //             ? CircularProgressIndicator()
// //             : ElevatedButton(
// //           onPressed: pickAndUploadVideo,
// //           child: Text("📤 Pick & Upload Video"),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// class NumberCheckPage extends StatefulWidget {
//   @override
//   _NumberCheckPageState createState() => _NumberCheckPageState();
// }
//
// class _NumberCheckPageState extends State<NumberCheckPage> {
//   final TextEditingController _controller = TextEditingController();
//   bool showWarning = false;
//
//   void _checkNumber(String value) {
//     final number = int.tryParse(value);
//     if (number != null && number < 50) {
//       setState(() {
//         showWarning = true;
//       });
//     } else {
//       setState(() {
//         showWarning = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('تحذير الرقم')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _controller,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'اكتب رقم',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: _checkNumber,
//             ),
//             SizedBox(height: 20),
//             if (showWarning)
//               AnimatedContainer(
//                 duration: Duration(milliseconds: 300),
//                 padding: EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.red[100],
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.red, width: 2),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.warning_amber_rounded, color: Colors.red, size: 30),
//                     SizedBox(width: 10),
//                     Text(
//                       'رك',
//                       style: TextStyle(
//                         color: Colors.red[900],
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Notification Scheduler',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: CreateQuestionScreen(),
// //     );
// //   }
// // }
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // final themeProvider = Provider.of<ThemeProvider>(context);
//     // final languageProvider = Provider.of<LanguageProvider>(context);
//
//     return ScreenUtilInit(
//       designSize: Size(375, 812), // Set the design size according to your design
//       minTextAdapt: true,
//       splitScreenMode: false,
//       builder: (context,child) {
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData.light(),
//           darkTheme: ThemeData.dark(),
//           // themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
//           // locale: languageProvider.locale,
//           supportedLocales: [Locale('en'), Locale('ar')],
//           home: NumberCheckPage(), // Your initial screen
//         );
//       },
//     );
//   }
// }
//
//
//
//
//
// class CreateQuestionScreen extends StatefulWidget {
//   @override
//   _CreateQuestionScreenState createState() => _CreateQuestionScreenState();
// }
//
// class _CreateQuestionScreenState extends State<CreateQuestionScreen> {
//   final _questionController = TextEditingController();
//   final _optionsController = TextEditingController();
//   final _correctAnswerController = TextEditingController();
//   DateTime? _selectedDateTime;
//
//   @override
//   void initState() {
//     super.initState();
//    }
//
//
//
//   Future<void> _createQuestion() async {
//     final questionText = _questionController.text;
//     final options = _optionsController.text.split(",").map((e) => e.trim()).toList();
//     final correctAnswer = _correctAnswerController.text;
//
//     if (questionText.isEmpty || options.length < 2 || correctAnswer.isEmpty ) {
//       _showErrorMessage('Please fill all fields and choose a time');
//       return;
//     }
//
//     try {
//       await FirebaseFirestore.instance.collection('questionnaire').add({
//         'questionText': questionText,
//         'options': options,
//         'correctAnswer': correctAnswer,
//
//       });
//
//
//       _clearFields();
//
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Question saved successfully'),
//       ));
//       Navigator.push(context, MaterialPageRoute(builder: (context)=>ScheduleNotificationPage()));
//     } catch (e) {
//       _showErrorMessage('Error saving question: $e');
//     }
//   }
//
//   void _clearFields() {
//     _questionController.clear();
//     _optionsController.clear();
//     _correctAnswerController.clear();
//     setState(() {
//       _selectedDateTime = null;
//     });
//   }
//
//   void _showErrorMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         txt: "Create Quiz",
//         isIconVisible: false,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             _buildTextField(_questionController, 'Enter question'),
//             SizedBox(height: 10),
//             _buildTextField(_optionsController, 'Enter options (comma separated)'),
//             SizedBox(height: 10),
//             _buildTextField(_correctAnswerController, 'Enter correct answer'),
//             SizedBox(height: 20),
//
//             SizedBox(height: 20),
//             CustomButton(text: 'Save Question', w: 300, onPressed: _createQuestion),
//             // ElevatedButton.icon(
//             //   onPressed: _createQuestion,
//             //   icon: Icon(Icons.save),
//             //   label: Text('Save Question'),
//             //   style: ElevatedButton.styleFrom(
//             //     backgroundColor: Colors.deepPurple,
//             //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String label) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(
//           color: Colors.grey[700],
//           fontWeight: FontWeight.bold,
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.blue, width: 2),
//         ),
//         filled: true,
//         fillColor: Colors.grey[100],
//          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//       ),
//     );
//
//   }
// }
//
//
//
//
//
// // تخزين الوقت في Firestore
// Future<void> storeNotificationTime(DateTime scheduledTime, String title, String body) async {
//   final notificationData = {
//     'scheduledAt': Timestamp.fromDate(scheduledTime),
//     'title': title,
//     'body': body,
//     'sent': false, // لتحديد إذا تم إرسال الإشعار أم لا
//   };
//
//   // تخزين الإشعار في Firestore
//   await FirebaseFirestore.instance.collection('scheduled_notifications').add(notificationData);
// }
//
// // مراقبة الوقت وإرسال الإشعار باستخدام Timer
// void checkScheduledNotifications() {
//   Timer.periodic(Duration(seconds: 30), (timer) async {
//     final now = DateTime.now();
//
//     // التحقق من وجود إشعارات قد حان وقتها
//     final snapshot = await FirebaseFirestore.instance
//         .collection('scheduled_notifications')
//         .where('scheduledAt', isLessThanOrEqualTo: now)
//         .where('sent', isEqualTo: false)
//         .get();
//
//     for (var doc in snapshot.docs) {
//       // استخراج البيانات من Firestore
//       final notificationData = doc.data();
//
//       // إرسال الإشعار عبر OneSignal
//       sendNotificationToOneSignal(notificationData['title'], notificationData['body']);
//
//       // تحديث حالة الإشعار ليتم إرسالها
//       await doc.reference.update({'sent': true});
//     }
//   });
// }
//
// // إرسال الإشعار باستخدام OneSignal
// Future<void> sendNotificationToOneSignal(String title, String body) async {
//   final String oneSignalAppId = "5f739295-3d77-474b-9d82-ce02ec408f66";  // استبدلها بمعرف التطبيق الخاص بك
//   final String oneSignalApiKey = "os_v2_app_l5zzffj5o5duxhmczyboyqepmz2c35tnvlxuaqf2ny3jzowd6ekexgoggbvvsmsmo556hoornbjc3xtq7yla6kzy7kf6bvqgfgju7oq"; // استبدلها بمفتاح API الخاص بك
//
//   final response = await http.post(
//       Uri.parse("https://onesignal.com/api/v1/notifications"),
//       headers: {
//         "Authorization": "Basic $oneSignalApiKey",
//         "Content-Type": "application/json"
//       },
//       body: '''
//     {
//       "app_id": "$oneSignalAppId",
//       "headings": {"en": "$title"},
//       "contents": {"en": "$body"},
//       "included_segments": ["All"]
//     }
//     '''
//   );
//
//   if (response.statusCode == 200) {
//     print("Notification sent successfully");
//   } else {
//     print("Failed to send notification");
//   }
// }
//
// // صفحة لاختيار الوقت والإشعار داخل التطبيق
// class ScheduleNotificationPage extends StatefulWidget {
//   @override
//   _ScheduleNotificationPageState createState() =>
//       _ScheduleNotificationPageState();
// }
//
// class _ScheduleNotificationPageState extends State<ScheduleNotificationPage> {
//   final titleController = TextEditingController();
//   final bodyController = TextEditingController();
//   DateTime? scheduledDate;
//
//   void _pickDateTime() async {
//     final date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now().add(Duration(minutes: 1)),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//
//     if (date == null) return;
//
//     final time = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now().replacing(
//         minute: (TimeOfDay.now().minute + 1) % 60,
//       ),
//     );
//
//     if (time == null) return;
//
//     final fullDateTime = DateTime(date.year, date.month, date.day, time.hour, time.minute);
//     setState(() {
//       scheduledDate = fullDateTime;
//     });
//   }
//
//   Future<void> _scheduleNotification() async {
//     if (titleController.text.isEmpty || bodyController.text.isEmpty || scheduledDate == null) return;
//
//     // تخزين الوقت في Firestore
//     await storeNotificationTime(scheduledDate!, titleController.text, bodyController.text);
//
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Notification Scheduled ✅')));
//     titleController.clear();
//     bodyController.clear();
//     setState(() {
//       scheduledDate = null;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final formattedDate = scheduledDate != null
//         ? DateFormat('yyyy-MM-dd HH:mm').format(scheduledDate!)
//         : 'Pick date & time';
//
//     return Scaffold(
//       appBar: CustomAppBar(txt: 'Schedule Notification', isIconVisible: false),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: titleController,
//               decoration:    InputDecoration(
//           labelText: 'Notification Title',
//           labelStyle: TextStyle(
//             color: Colors.grey[700],
//             fontWeight: FontWeight.bold,
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.blue, width: 2),
//           ),
//           filled: true,
//           fillColor: Colors.grey[100],
//           contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//         ),
//             ),
//             SizedBox(height: 30,),
//             TextField(
//               controller: bodyController,
//               decoration:   InputDecoration(
//               labelText: 'Notification body',
//               labelStyle: TextStyle(
//                 color: Colors.grey[700],
//                 fontWeight: FontWeight.bold,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.blue, width: 2),
//               ),
//               filled: true,
//               fillColor: Colors.grey[100],
//               contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//             ),
//             ),
//             SizedBox(height: 20),
//             Align(
//               alignment: Alignment.topRight,
//               child: TextButton.icon(
//                 onPressed: _pickDateTime,
//                 icon: Icon(Icons.calendar_today,color: Color(0xFF1E1F22),),
//                 label: Text(formattedDate,style: TextStyle(
//                   color: Color(0xFF1E1F22)
//                 ),),
//               ),
//             ),
//             SizedBox(height: 20),
//             CustomButton(text: 'Send', w: 320, onPressed: _scheduleNotification)
//
//           ],
//         ),
//       ),
//     );
//   }
// }



























////////////////////// test notication alerts     ////////


import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FocusNotifierScreen(),
    );
  }
}

class FocusNotifierScreen extends StatefulWidget {
  @override
  _FocusNotifierScreenState createState() => _FocusNotifierScreenState();
}

class _FocusNotifierScreenState extends State<FocusNotifierScreen> {
  final TextEditingController _controller = TextEditingController();

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'focus_channel',
      'Focus Alerts',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  void _checkFocusAndNotify(String value) {
    final focus = double.tryParse(value);
    if (focus == null) return;

    if (focus < 40) {
      _showNotification("انتباه!", "نسبة تركيزك منخفضة، ركّز شوية 💡");
    } else if (focus >= 40 && focus <= 70) {
      _showNotification("تمام 👍", "أداءك متوسط، استمر كده!");
    } else if (focus > 70) {
      _showNotification("حماسك زايد 🔥", "ركز أقل شوية، خليك هادي ومتزن.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Focus Checker")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'اكتب نسبة تركيزك',
            border: OutlineInputBorder(),
          ),
          onFieldSubmitted: _checkFocusAndNotify,
        ),
      ),
    );
  }
}


