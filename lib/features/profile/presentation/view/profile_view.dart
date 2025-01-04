import 'package:flutter/material.dart';
import 'package:online_meeting/features/profile/presentation/view/widgets/log_out_dialog.dart';

import '../../../home/presentation/view/home_view.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfileView()));
            },
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "Edit Profile",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontFamily: 'Diphylleia'),
              ),
            ),
          ),
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/img3.jpeg'),
          ),
          SizedBox(height: 20),
          // Name
          Text(
            'x',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          // Email
          Text(
            'x@gmail.com', // Replace with user's email
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 30),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: "Sevillana"),
            ),
            onTap: () {
              // Add navigation to settings page
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Sevillana"),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LogOutDialog();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
