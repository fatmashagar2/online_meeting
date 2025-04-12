import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_meeting/splash/presentation/view/splash_view.dart';
import 'package:provider/provider.dart';
//import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/themes/theme_provider.dart';
import 'features/auth/presentation/view/login_view.dart';
import 'features/profile/presentation/view_model/language_provider.dart';

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
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return ScreenUtilInit(
      designSize: Size(375, 812), // Set the design size according to your design
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context,child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          locale: languageProvider.locale,
          supportedLocales: [Locale('en'), Locale('ar')],
          home: SplashView(), // Your initial screen
        );
      },
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// void main() => runApp(const MyApp());
//
//
//
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: MeetingPage(),
//     );
//   }
// }
//
// class MeetingPage extends StatefulWidget {
//   const MeetingPage({super.key});
//
//   @override
//   State<MeetingPage> createState() => _MeetingPageState();
// }
//
// class _MeetingPageState extends State<MeetingPage> {
//   late final RtcEngine _agoraEngine;
//   final String _appId = "1d51a9a0f2b14b5783442d3a36a52f61";
//   final String _channelName = "testChannel";
//   final List<int> _remoteUids = [];
//   bool _isJoined = false;
//   bool _isMuted = false;
//   bool _isVideoOn = true;
//   bool _isSharingScreen = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeAgora();
//   }
//
//   Future<void> _initializeAgora() async {
//     await [
//       Permission.microphone,
//       Permission.camera,
//       Permission.systemAlertWindow,
//       Permission.bluetooth,
//       Permission.bluetoothConnect,
//     ].request();
//
//     _agoraEngine = createAgoraRtcEngine();
//     await _agoraEngine.initialize(RtcEngineContext(appId: _appId));
//
//     await _agoraEngine.setChannelProfile(
//         ChannelProfileType.channelProfileCommunication);
//     await _agoraEngine.enableVideo();
//     await _agoraEngine.startPreview();
//
//     _setupEventHandlers();
//   }
//
//   void _setupEventHandlers() {
//     _agoraEngine.registerEventHandler(
//       RtcEngineEventHandler(
//         onJoinChannelSuccess: (RtcConnection conn, int elapsed) {
//           setState(() => _isJoined = true);
//         },
//         onUserJoined: (RtcConnection conn, int uid, int elapsed) {
//           if (!_remoteUids.contains(uid)) {
//             setState(() => _remoteUids.add(uid));
//           }
//         },
//         onUserOffline: (RtcConnection conn, int uid, UserOfflineReasonType reason) {
//           setState(() => _remoteUids.remove(uid));
//         },
//         onLocalVideoStateChanged: (
//             VideoSourceType source,
//             LocalVideoStreamState state,
//             LocalVideoStreamReason reason,
//             ) {
//           if (source == VideoSourceType.videoSourceScreen) {
//             setState(() {
//               _isSharingScreen = state == LocalVideoStreamState.localVideoStreamStateCapturing;
//             });
//           }
//         },
//       ),
//     );
//   }
//
//   Future<void> _joinChannel() async {
//     try {
//       await _agoraEngine.joinChannel(
//           token: "007eJxTYDiu7rdtxtZ3CdfLpIrNvea3puT+e/9lds3cSjO2hHeTbgsqMJiYJRsZGCaaGVmaGZtYmKYmGhimpqaZm5onm5knGRgnZyZ8SG8IZGSI0WtjYWSAQBCfm6EktbjEOSMxLy81h4EBAJIzIvI=",
//         channelId: _channelName,
//         uid: 0,
//         options: const ChannelMediaOptions(
//           channelProfile: ChannelProfileType.channelProfileCommunication,
//           clientRoleType: ClientRoleType.clientRoleBroadcaster,
//           publishCameraTrack: true,
//           publishScreenTrack: false,
//         ),
//       );
//     } catch (e) {
//       print("Join error: $e");
//     }
//   }
//
//   Future<void> _leaveChannel() async {
//     await _agoraEngine.leaveChannel();
//     setState(() {
//       _isJoined = false;
//       _remoteUids.clear();
//     });
//   }
//
//   void _toggleMic() {
//     _agoraEngine.muteLocalAudioStream(!_isMuted);
//     setState(() => _isMuted = !_isMuted);
//   }
//
//   void _toggleCamera() {
//     _agoraEngine.muteLocalVideoStream(!_isVideoOn);
//     setState(() => _isVideoOn = !_isVideoOn);
//   }
//
//   Future<void> _toggleScreenSharing() async {
//     try {
//       if (!_isSharingScreen) {
//         await _agoraEngine.startScreenCapture(
//           const ScreenCaptureParameters2(
//             captureAudio: true,
//             captureVideo: true,
//             videoParams: ScreenVideoParameters(
//               dimensions: VideoDimensions(width: 1280, height: 720),
//             ),
//           ),
//         );
//         await _agoraEngine.updateChannelMediaOptions(
//           ChannelMediaOptions(
//             publishCameraTrack: false,
//             publishScreenTrack: true,
//           ),
//         );
//       } else {
//         await _agoraEngine.stopScreenCapture();
//         await _agoraEngine.updateChannelMediaOptions(
//           ChannelMediaOptions(
//             publishCameraTrack: true,
//             publishScreenTrack: false,
//           ),
//         );
//       }
//       setState(() => _isSharingScreen = !_isSharingScreen);
//     } catch (e) {
//       print("Screen sharing error: $e");
//     }
//   }
//
//   Widget _buildMainScreen() {
//     return Container(
//       color: Colors.black,
//       child: _isSharingScreen
//           ? AgoraVideoView(
//         controller: VideoViewController(
//           rtcEngine: _agoraEngine,
//           canvas: const VideoCanvas(uid: 0),
//           // استبدل بالباراميتر الصحيح إذا لزم الأمر
//           // sourceType: VideoSourceType.videoSourceScreen,
//         ),
//       )
//           : AgoraVideoView(
//         controller: VideoViewController(
//           rtcEngine: _agoraEngine,
//           canvas: const VideoCanvas(uid: 0),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildParticipantsGrid() {
//     return Container(
//       width: 150,
//       height: 200,
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.3),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 1,
//           childAspectRatio: 0.8,
//         ),
//         itemCount: _remoteUids.length + 1,
//         itemBuilder: (context, index) {
//           if (index == 0) return _buildLocalPreview();
//           return _remoteVideo(_remoteUids[index - 1]);
//         },
//       ),
//     );
//   }
//
//   Widget _buildLocalPreview() {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: AgoraVideoView(
//           controller: VideoViewController(
//             rtcEngine: _agoraEngine,
//             canvas: const VideoCanvas(uid: 0),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _remoteVideo(int uid) {
//     return Padding(
//       padding: const EdgeInsets.all(4.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: AgoraVideoView(
//           controller: VideoViewController.remote(
//             rtcEngine: _agoraEngine,
//             canvas: VideoCanvas(uid: uid),
//             connection: RtcConnection(channelId: _channelName),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildWaitingScreen() {
//     return const Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.videocam_off, size: 80, color: Colors.grey),
//           SizedBox(height: 20),
//           Text('انضم إلى الاجتماع الآن', style: TextStyle(fontSize: 18)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildControlBar() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       color: Colors.black.withOpacity(0.1),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           IconButton(
//             icon: Icon(_isMuted ? Icons.mic_off : Icons.mic, size: 32),
//             color: _isMuted ? Colors.red : Colors.blue,
//             onPressed: _toggleMic,
//           ),
//           IconButton(
//             icon: Icon(_isVideoOn ? Icons.videocam : Icons.videocam_off, size: 32),
//             color: _isVideoOn ? Colors.blue : Colors.red,
//             onPressed: _toggleCamera,
//           ),
//           IconButton(
//             icon: Icon(
//               _isSharingScreen ? Icons.stop_screen_share : Icons.screen_share,
//               size: 32,
//             ),
//             color: _isSharingScreen ? Colors.green : Colors.grey,
//             onPressed: _toggleScreenSharing,
//           ),
//           ElevatedButton.icon(
//             icon: const Icon(Icons.logout),
//             label: Text(_isJoined ? 'مغادرة' : 'انضمام'),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: _isJoined ? Colors.red : Colors.green,
//               foregroundColor: Colors.white,
//             ),
//             onPressed: _isJoined ? _leaveChannel : _joinChannel,
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('اجتماع Agora'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: _isJoined
//                 ? Stack(
//               children: [
//                 _buildMainScreen(),
//                 Positioned(
//                   top: 20,
//                   right: 20,
//                   child: _buildParticipantsGrid(),
//                 ),
//               ],
//             )
//                 : _buildWaitingScreen(),
//           ),
//           _buildControlBar(),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _agoraEngine.release();
//     super.dispose();
//   }
// }


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home: LoginView());
//   }
// }

// class MeetingPage extends StatefulWidget {
//   const MeetingPage({super.key});
//
//   @override
//   State<MeetingPage> createState() => _MeetingPageState();
// }
//
// class _MeetingPageState extends State<MeetingPage> {
//   final TextEditingController _conferenceIdController = TextEditingController();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Future<void> _joinConference({required bool isCreating}) async {
//     final String conferenceId = isCreating
//         ? const Uuid().v4().substring(0, 8)
//         : _conferenceIdController.text.trim();
//
//     if (!isCreating && conferenceId.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please enter a Conference ID to join")),
//       );
//       return;
//     }
//
//     if (isCreating) {
//       await _firestore.collection("meetings").doc(conferenceId).set({
//         "createdAt": Timestamp.now(),
//       });
//     } else {
//       final doc = await _firestore.collection("meetings").doc(conferenceId).get();
//       if (!doc.exists) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Meeting ID does not exist")),
//         );
//         return;
//       }
//     }
//
//     final String userId = const Uuid().v4().substring(0, 6);
//     final String userName = "User_$userId";
//
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => VedoiConfernce(
//           confernceID: conferenceId,
//           userID: userId,
//           userName: userName,
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Create / Join Meeting")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _conferenceIdController,
//               decoration: const InputDecoration(
//                 labelText: 'Conference ID (for Join only)',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _joinConference(isCreating: true),
//                     child: const Text("Create Meeting"),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () => _joinConference(isCreating: false),
//                     child: const Text("Join Meeting"),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class VedoiConfernce extends StatelessWidget {
//   final String confernceID;
//   final String userID;
//   final String userName;
//
//   const VedoiConfernce({
//     super.key,
//     required this.confernceID,
//     required this.userID,
//     required this.userName,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ZegoUIKitPrebuiltVideoConference(
//         appID: 1823359901,
//         appSign:
//         'f19b83ba31160e666d62cad5a6d6e2272126ed6699313a7eeedc5916fd721a77',
//         conferenceID: confernceID,
//         userID: userID,
//         userName: userName,
//         config: ZegoUIKitPrebuiltVideoConferenceConfig(),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
//
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// import 'dart:math';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
//
// import 'package:flutter/material.dart';
//
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
// import 'dart:math';
//
// // void main() => runApp(const MaterialApp(home: SplashView(),));
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final JitsiMeet _jitsiMeet = JitsiMeet();
//   final String _serverUrl = "https://8x8.vc/vpaas-magic-cookie-99476734cde9462aa129ec8010493317";
//   final String _tenant = "EDU%20FOCUS";
//
//   String _generateRoomId() {
//     return 'room_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999)}';
//   }
//
//   Future<void> _startMeeting() async {
//     try {
//       final roomId = _generateRoomId();
//       final options = JitsiMeetConferenceOptions(
//         serverURL: _serverUrl,
//         room: "$_tenant/$roomId",
//         configOverrides: {
//           "startWithAudioMuted": true,
//           "startWithVideoMuted": true,
//           "prejoinPageEnabled": false,
//         },
//         featureFlags: {
//           "welcomePage.enabled": false,
//           "resolution": 360,
//         },
//         userInfo: JitsiMeetUserInfo(
//           displayName: "فاطمه (مشرفة)",
//           email: "fatmashagar64@gmail.com",
//         ),
//       );
//
//       final listener = JitsiMeetEventListener(
//         conferenceJoined: (String url) {
//           debugPrint("✅ تم الانضمام إلى الاجتماع: $url");
//         },
//
//
//         conferenceTerminated: (String url, Object? error) {
//           debugPrint("⛔ انتهى الاجتماع: $url");
//           return null;
//         },
//         participantJoined: (email, name, role, participantId) {
//           debugPrint("👤 انضم: $name");
//           return null;
//         },
//       );
//
//       await _jitsiMeet.join(options, listener);
//     } catch (e) {
//       debugPrint("🔥 خطأ عام: ${e.toString()}");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('منصة التعليم'),
//           backgroundColor: Colors.blue.shade800,
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: _startMeeting,
//             child: const Text("ابدأ الاجتماع"),
//           ),
//         ),
//       ),
//     );
//   }
// }