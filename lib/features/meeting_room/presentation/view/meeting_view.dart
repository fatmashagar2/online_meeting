// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
// import 'package:online_meeting/features/custom_app_bar.dart';
//
// class ZoomMeetingPage extends StatefulWidget {
//   @override
//   _ZoomMeetingPageState createState() => _ZoomMeetingPageState();
// }
//
// class _ZoomMeetingPageState extends State<ZoomMeetingPage> {
//   final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
//   MediaStream? _localStream;
//
//   bool isMicOn = true;
//   bool isScreenSharing = false;
//   String? meetingId;
//   List<Map<String, String>> participants = List.generate(
//     10,
//         (index) => {
//       'name': 'Participant ${index + 1}',
//       'image': 'https://randomuser.me/api/portraits/men/${index + 1}.jpg',
//     },
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     _initialize();
//   }
//
//   Future<void> _initialize() async {
//     meetingId = DateTime.now().millisecondsSinceEpoch.toString();
//     FirebaseFirestore.instance.collection('meetings').doc(meetingId).set({
//       'createdAt': DateTime.now(),
//       'participants': [],
//     });
//     await _startCamera();
//   }
//
//   @override
//   void dispose() {
//     _localRenderer.dispose();
//     _localStream?.dispose();
//     super.dispose();
//   }
//
//   Future<void> _startCamera() async {
//     await _localRenderer.initialize();
//     final stream = await navigator.mediaDevices.getUserMedia({
//       'video': {'facingMode': 'user'},
//       'audio': true,
//     });
//
//     setState(() {
//       _localStream = stream;
//       _localRenderer.srcObject = stream;
//     });
//   }
//
//   void _showParticipants() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ParticipantsPage(participants: participants),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(txt: "Meeting Room", isIconVisible: false,),
//       body: ZoomMeetingBody(
//         localRenderer: _localRenderer,
//         localStream: _localStream,
//         isScreenSharing: isScreenSharing,
//         onToggleScreenSharing: _toggleScreenSharing,
//         participants: participants,
//       ),
//       bottomNavigationBar: ZoomMeetingBottomNavBar(
//         isMicOn: isMicOn,
//         isScreenSharing: isScreenSharing,
//         onToggleMic: _toggleMic,
//         onEndCall: _endCall,
//         onToggleScreenSharing: _toggleScreenSharing,
//         onShowParticipants: _showParticipants,
//       ),
//     );
//   }
//
//   void _toggleMic() {
//     setState(() {
//       isMicOn = !isMicOn;
//     });
//   }
//
//   void _endCall() {
//     Navigator.pop(context);
//   }
//
//   Future<void> _toggleScreenSharing() async {
//     setState(() {
//       isScreenSharing = !isScreenSharing;
//     });
//
//     if (isScreenSharing) {
//       await _localStream?.dispose();
//       final stream = await navigator.mediaDevices.getDisplayMedia({
//         'video': {'mediaSource': 'screen'},
//       });
//
//       setState(() {
//         _localStream = stream;
//         _localRenderer.srcObject = stream;
//       });
//     } else {
//       await _localStream?.dispose();
//       _startCamera();
//     }
//   }
// }
//
// class ZoomMeetingBody extends StatelessWidget {
//   final RTCVideoRenderer localRenderer;
//   final MediaStream? localStream;
//   final bool isScreenSharing;
//   final VoidCallback onToggleScreenSharing;
//   final List<Map<String, String>> participants;
//
//   ZoomMeetingBody({
//     required this.localRenderer,
//     required this.localStream,
//     required this.isScreenSharing,
//     required this.onToggleScreenSharing,
//     required this.participants,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Column(
//           children: [
//             Expanded(
//               flex: 3,
//               child: Container(
//
//                 child: isScreenSharing
//                     ? RTCVideoView(localRenderer, mirror: false)
//                     : Center(
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 30),
//                     child: Column(
//                       children: [
//                         Image.asset("assets/opps.gif"),
//                         Text(
//                           "No Screen Sharing",
//                           style: TextStyle(color: Colors.black, fontSize: 30,fontFamily: 'Sevillana'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// class ZoomMeetingBottomNavBar extends StatelessWidget {
//   final bool isMicOn;
//   final bool isScreenSharing;
//   final VoidCallback onToggleMic;
//   final VoidCallback onEndCall;
//   final VoidCallback onToggleScreenSharing;
//   final VoidCallback onShowParticipants;
//
//   ZoomMeetingBottomNavBar({
//     required this.isMicOn,
//     required this.isScreenSharing,
//     required this.onToggleMic,
//     required this.onEndCall,
//     required this.onToggleScreenSharing,
//     required this.onShowParticipants,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none, // للسماح للظل بالخروج عن حدود العنصر
//       children: [
//         Positioned(
//           top: -5, // لضبط موقع الظل فوق العنصر
//           left: 0,
//           right: 0,
//           child: Container(
//             height: 10,
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0xff1E54A6).withOpacity(0.5),
//                   blurRadius: 8.8,
//                   offset: const Offset(0, 0),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xff092147), Color(0xff1E54A6)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             border: Border(
//               bottom: BorderSide(
//                 color: Color(0xff1E54A6),
//                 width: 0.5,
//               ),
//             ),
//           ),
//           child: BottomNavigationBar(
//             selectedItemColor: Colors.white, // لون العنصر المحدد
//             unselectedItemColor: Colors.white, // لون العنصر غير المحدد
//             backgroundColor: Colors.transparent, // خلفية شفافة
//             currentIndex: 0,
//             type: BottomNavigationBarType.fixed,
//             onTap: (index) {
//               switch (index) {
//                 case 0:
//                   onShowParticipants();
//                   break;
//                 case 1:
//                   onToggleMic();
//                   break;
//                 case 2:
//                   onToggleScreenSharing();
//                   break;
//                 case 3:
//                   onEndCall();
//                   break;
//               }
//             },
//             items: [
//               BottomNavigationBarItem(
//                 icon: CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.transparent,
//                   child: Icon(Icons.person, color: Colors.white),
//                 ),
//                 label: "Participants",
//               ),
//               BottomNavigationBarItem(
//                 icon: CircleAvatar(
//                   backgroundColor: Colors.transparent,
//                   radius: 30,
//                   child: Icon(isMicOn ? Icons.mic : Icons.mic_off, color: Colors.white),
//                 ),
//                 label: isMicOn ? "Mic On" : "Mic Off",
//               ),
//               BottomNavigationBarItem(
//                 icon: CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.green, // لون أخضر
//                   child: Icon(
//                     isScreenSharing ? Icons.ios_share : Icons.ios_share,
//                     color: Colors.white,
//                   ),
//                 ),
//                 label: isScreenSharing ? "Stop Sharing" : "Share Screen",
//               ),
//               BottomNavigationBarItem(
//                 icon: CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.red, // لون أحمر
//                   child: Icon(Icons.call_end, color: Colors.white),
//                 ),
//                 label: "End Call",
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//
//   }
// }
//
// class ParticipantsPage extends StatefulWidget {
//   final List<Map<String, String>> participants;
//
//   ParticipantsPage({required this.participants});
//
//   @override
//   _ParticipantsPageState createState() => _ParticipantsPageState();
// }
//
// class _ParticipantsPageState extends State<ParticipantsPage> {
//   late RTCVideoRenderer _renderer;
//   MediaStream? _localStream;
//
//   @override
//   void initState() {
//     super.initState();
//     _renderer = RTCVideoRenderer();
//     _initializeCamera();
//   }
//
//   Future<void> _initializeCamera() async {
//     await _renderer.initialize();
//
//     _localStream = await navigator.mediaDevices.getUserMedia({
//       'video': true,
//     });
//
//     _renderer.srcObject = _localStream;
//     setState(() {});
//   }
//
//   @override
//   void dispose() {
//     _renderer.dispose();
//     _localStream?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Icon(Icons.arrow_back_ios,color: Colors.white,),
//         backgroundColor: Color(0xFF2d3e50),
//         title: Text('Participants',style: TextStyle(
//           color: Colors.white,
//           fontFamily: "Sevillana",
//             fontWeight: FontWeight.bold
//
//         ),),
//       ),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 1.0,
//         ),
//         itemCount: widget.participants.length + 1,
//         itemBuilder: (context, index) {
//           final participantIndex = index + 1;
//           final isMyCamera = index == 0;
//
//           final RTCVideoRenderer renderer = RTCVideoRenderer();
//           renderer.initialize();
//
//           return Stack(
//             children: [
//               Container(
//                 child: isMyCamera
//                     ? (_localStream != null
//                     ? RTCVideoView(_renderer, mirror: true)
//                     : CircularProgressIndicator())
//                     : RTCVideoView(
//                   renderer,
//                   mirror: true,
//                 ),
//               ),
//               Positioned(
//                 bottom: 8,
//                 right: 8,
//                 child: CircleAvatar(
//                   backgroundImage: NetworkImage(
//                     widget.participants[participantIndex]['image']!,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 8,
//                 left: 8,
//                 child: Text(
//                   widget.participants[participantIndex]['name']!,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
// class ParticipantsPage extends StatefulWidget {
//   final List<Map<String, String>> participants;
//
//   ParticipantsPage({required this.participants});
//
//   @override
//   _ParticipantsPageState createState() => _ParticipantsPageState();
// }
//
// class _ParticipantsPageState extends State<ParticipantsPage> {
//   late RTCVideoRenderer _renderer;
//   MediaStream? _localStream;
//
//   @override
//   void initState() {
//     super.initState();
//     _renderer = RTCVideoRenderer();
//     _initializeCamera();
//   }
//
//   Future<void> _initializeCamera() async {
//     await _renderer.initialize();
//
//     // Access the camera stream for the local user (your camera)
//     _localStream = await navigator.mediaDevices.getUserMedia({
//       'video': true,
//     });
//
//     // Set the local stream to the renderer
//     _renderer.srcObject = _localStream;
//     setState(() {});  // Update the UI once the camera is initialized
//   }
//
//   @override
//   void dispose() {
//     _renderer.dispose();
//     _localStream?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:CustomAppBar(txt: "Participants", isIconVisible: false,),
//       body: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 1.0,
//         ),
//         itemCount: widget.participants.length,  // Use the actual number of participants
//         itemBuilder: (context, index) {
//           return Stack(
//             children: [
//               // Full container with your local camera stream
//               Container(
//                 color: Colors.black,
//                 width: double.infinity,
//                 height: double.infinity,
//                 child: _localStream != null
//                     ? RTCVideoView(
//                   _renderer,
//                   mirror: true,
//                   objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover, // This ensures the camera covers the full container
//                 )
//                     : Center(child: CupertinoActivityIndicator()),
//               ),
//               // Optionally display participant info on top of the camera feed
//               Positioned(
//                 bottom: 8,
//                 left: 8,
//                 child: Text(
//                   widget.participants[index]['name']!,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//

