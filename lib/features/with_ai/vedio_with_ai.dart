import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

// class UploadVideoScreen extends StatefulWidget {
//   const UploadVideoScreen({super.key});
//
//   @override
//   State<UploadVideoScreen> createState() => _UploadVideoScreenState();
// }
//
// class _UploadVideoScreenState extends State<UploadVideoScreen> {
//   double? _averageFocusScore;
//   bool _isLoading = false;
//
//   Future<void> _pickAndUploadVideosSequentially() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.video,
//       allowMultiple: true,
//     );
//
//     if (result == null || result.files.length != 4) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('اختار ٤ فيديوهات فقط')),
//       );
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//       _averageFocusScore = null;
//     });
//
//     double totalScore = 0;
//     int successCount = 0;
//
//     for (int i = 0; i < result.files.length; i++) {
//       final file = File(result.files[i].path!);
//
//       var request = http.MultipartRequest(
//         'POST',
//         Uri.parse('https://foucs.onrender.com/analyze'),
//       );
//       request.files.add(await http.MultipartFile.fromPath('file', file.path));
//
//       try {
//         var response = await request.send();
//         final resBody = await response.stream.bytesToString();
//         if (response.statusCode == 200) {
//           final jsonData = json.decode(resBody);
//           double score = double.tryParse(jsonData['focus_score'].toString()) ?? 0.0;
//           totalScore += score;
//           successCount++;
//         } else {
//           debugPrint('فشل رفع الفيديو رقم ${i + 1}');
//         }
//       } catch (e) {
//         debugPrint('خطأ في رفع الفيديو رقم ${i + 1}: $e');
//       }
//     }
//
//     setState(() {
//       _isLoading = false;
//       if (successCount == 4) {
//         _averageFocusScore = totalScore / 4;
//       } else {
//         _averageFocusScore = null;
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('فشل رفع بعض الفيديوهات')),
//         );
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Upload 4 Videos'),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ElevatedButton.icon(
//                 onPressed: _isLoading ? null : _pickAndUploadVideosSequentially,
//                 icon: const Icon(FontAwesomeIcons.upload, size: 20),
//                 label: const Text(
//                   'Upload 4 Videos',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//                   backgroundColor: Colors.redAccent,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               if (_isLoading)
//                 const CircularProgressIndicator()
//               else if (_averageFocusScore != null)
//                 Text(
//                   'Average Focus Score: ${_averageFocusScore!.toStringAsFixed(2)}',
//                   style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({super.key});

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  List<double> _focusScores = [];
  double? _averageFocusScore;
  bool _isLoading = false;

  Future<void> _pickAndUploadVideosSequentially() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: true,
    );

    if (result == null || result.files.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اختار ٤ فيديوهات فقط')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _focusScores.clear();
      _averageFocusScore = null;
    });

    double totalScore = 0;
    int successCount = 0;

    for (int i = 0; i < result.files.length; i++) {
      final file = File(result.files[i].path!);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://foucs.onrender.com/analyze'),
      );
      request.files.add(await http.MultipartFile.fromPath('file', file.path));

      try {
        var response = await request.send();
        final resBody = await response.stream.bytesToString();
        if (response.statusCode == 200) {
          final jsonData = json.decode(resBody);
          double score = double.tryParse(jsonData['focus_score'].toString()) ?? 0.0;
          totalScore += score;
          _focusScores.add(score);
          successCount++;
        } else {
          debugPrint('فشل رفع الفيديو رقم ${i + 1}');
        }
      } catch (e) {
        debugPrint('خطأ في رفع الفيديو رقم ${i + 1}: $e');
      }
    }

    setState(() {
      _isLoading = false;
      if (successCount == 4) {
        _averageFocusScore = totalScore / 4;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FocusNotifierScreen(focusLevels: _focusScores),
          ),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل رفع بعض الفيديوهات')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload 4 Videos'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _pickAndUploadVideosSequentially,
                icon: const Icon(FontAwesomeIcons.upload, size: 20),
                label: const Text(
                  'Upload 4 Videos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              if (_isLoading)
                const CircularProgressIndicator()
              else if (_focusScores.isNotEmpty) ...[
                const Text(
                  'Focus Scores:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                for (int i = 0; i < _focusScores.length; i++)
                  Text('Video ${i + 1}: ${_focusScores[i].toStringAsFixed(2)}'),
                const SizedBox(height: 20),
                Text(
                  'Average Focus Score: ${_averageFocusScore?.toStringAsFixed(2) ?? "-"}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class FocusNotifierScreen extends StatefulWidget {
  final List<double> focusLevels;

  const FocusNotifierScreen({Key? key, required this.focusLevels}) : super(key: key);

  @override
  _FocusNotifierScreenState createState() => _FocusNotifierScreenState();
}

class _FocusNotifierScreenState extends State<FocusNotifierScreen> {
  late List<double> focusLevels;

  @override
  void initState() {
    super.initState();
    focusLevels = widget.focusLevels; // هنا التهيئة الصح
    startFocusNotifications();
  }

  int currentIndex = 0;
  Timer? focusTimer;



  @override
  void dispose() {
    focusTimer?.cancel();
    super.dispose();
  }

  void startFocusNotifications() {
    focusTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      if (currentIndex < focusLevels.length) {
        _checkFocusAndNotify(focusLevels[currentIndex]);
        currentIndex++;
      } else {
        timer.cancel(); // خلصنا الليست
      }
    });
  }

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

  void _checkFocusAndNotify(double focus) {
    if (focus < 40) {
      _showNotification("ركز يلا! 👀", "نسبة تركيزك واطية، صحصح كده 💡");
    } else if (focus >= 40 && focus <= 70) {
      _showNotification("تمام كده 👍", "أداءك كويس، استمر بنفس القوة!");
    } else if (focus > 70) {
      _showNotification("عاش 💪", "أداء ممتاز، خليك كده دايمًا!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Focus Auto Checker")),
      body: Center(
        child: Text(
          "هيتم إرسال إشعارات كل 5 دقايق حسب نسبة التركيز",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
