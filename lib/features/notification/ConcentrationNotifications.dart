import 'package:flutter/material.dart';

class ConcentrationNotifications extends StatelessWidget {
  const ConcentrationNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Concentration',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: null,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          NotificationCard(
            image: 'assets/3.jpg',
            title: 'High engagement detected in Math class.',
            average: '85%',
            time: 'Real-',
            isRecent: true,
          ),
          NotificationCard(
            image: 'assets/3.jpg',
            title: 'Low concentration observed in English class.',
            average: '45%',
            time: 'Yesterday',
            isRecent: true,
          ),
          NotificationCard(
            image: 'assets/3.jpg',
            title: 'Moderate focus seen in Science class.',
            average: '65%',
            time: '05/09/2023',
          ),
          NotificationCard(
            image: 'assets/3.jpg',
            title: 'High engagement detected in History class.',
            average: '80%',
            time: '01/09/2023',
          ),
          NotificationCard(
            image: 'assets/3.jpg',
            title: 'Low concentration observed in Geography class.',
            average: '40%',
            time: '31/08/2023',
          ),
          NotificationCard(
            image: 'assets/3.jpg',
            title: 'Moderate focus seen in Art class.',
            average: '60%',
            time: '31/08/2023',
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
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
    return Card(
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
    );
  }
}