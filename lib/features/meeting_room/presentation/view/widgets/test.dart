import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Test extends StatelessWidget {
  const Test({super.key});
  Future<void> _shareLink() async {
    const link = 'https://example.com';
    final url = 'whatsapp://send?text=$link';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('لا يمكن فتح التطبيق');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Page'),
      ),
      body: Center(
        child: IconButton(
          icon: Icon(Icons.share),
          onPressed: _shareLink,
        ),
      ),
    );
  }
}
