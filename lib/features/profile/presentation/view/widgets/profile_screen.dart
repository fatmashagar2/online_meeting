import 'package:flutter/material.dart';

import '../../../../custom_app_bar.dart';
import '../../../../home/presentation/view/home_view.dart';
import '../edit_profile_view.dart';
import '../profile_view.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: CustomAppBar(txt: "Profile And Edit Profile"),
        body: TabBarView(
          children: [
            ProfileView(),

            EditProfileView(),
          ],
        ),
      ),
    );
  }
}
