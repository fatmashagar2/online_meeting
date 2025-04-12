import 'package:flutter/material.dart';
import 'package:online_meeting/features/custom_app_bar.dart';

class FocusIndicator extends StatelessWidget {
  final String avatarImage;
  final double focusPercentage;
  final String name;

  const FocusIndicator({
    Key? key,
    required this.avatarImage,
    required this.focusPercentage,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(avatarImage),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: focusPercentage,
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  color: focusPercentage > 0.75 ? Colors.green : Colors.orange,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${(focusPercentage * 100).toStringAsFixed(0)}%',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class FocusList extends StatelessWidget {
  final List<Map<String, dynamic>> people = [
    {
      'name': 'A',
      'avatar': 'assets/img3.jpeg',
      'focus': 0.9,
    },
    {
      'name': 'B',
      'avatar': 'assets/img3.jpeg',
      'focus': 0.4,
    },
    {
      'name': 'C',
      'avatar': 'assets/img3.jpeg',
      'focus': 0.0,
    },
    {
      'name': 'D',
      'avatar': 'assets/img3.jpeg',
      'focus': 0.2,
    },
    {
      'name': 'E',
      'avatar': 'assets/img3.jpeg',
      'focus': 0.8,
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(txt: "Focus Level", isIconVisible: false,),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return FocusIndicator(
            avatarImage: person['avatar'],
            focusPercentage: person['focus'],
            name: person['name'],
          );
        },
      ),
    );
  }
}


