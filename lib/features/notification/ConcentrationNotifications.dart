import 'package:flutter/material.dart';
import 'package:online_meeting/features/custom_app_bar.dart';

import '../StudentConcentrationReport.dart';

class ConcentrationNotifications extends StatelessWidget {
  const ConcentrationNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(txt: "Concentration", isIconVisible: false),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          NotificationCard(
            image: 'assets/img2.png',
            title: 'High engagement detected in #14587963.',
            average: '85%',
            time: 'Real-',
            isRecent: true,
          ),
          NotificationCard(
            image: 'assets/img2.png',
            title: 'Low concentration observed in #15369874.',
            average: '45%',
            time: 'Yesterday',
            isRecent: true,
          ),
          NotificationCard(
            image: 'assets/img2.png',
            title: 'Moderate focus seen in #13698532.',
            average: '65%',
            time: '05/09/2023',
          ),
          NotificationCard(
            image: 'assets/img2.png',
            title: 'High engagement detected in #14785236.',
            average: '80%',
            time: '01/09/2023',
          ),
          NotificationCard(
            image: 'assets/img2.png',
            title: 'Low concentration observed in #12547896.',
            average: '40%',
            time: '31/08/2023',
          ),
          NotificationCard(
            image: 'assets/img2.png',
            title: 'Moderate focus seen in #12365789.',
            average: '60%',
            time: '31/08/2023',
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String image;
  final String title;
  final String average;
  final String time;
  final bool isRecent;

  const NotificationCard({
    super.key,
    required this.image,
    required this.title,
    required this.average,
    required this.time,
    this.isRecent = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StudentConcentrationReport()));
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Class Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Average: $average',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        if (isRecent) ...[
                          const SizedBox(width: 4),
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
