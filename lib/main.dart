import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_meeting/features/custom_app_bar.dart';
import 'features/auth/presentation/view/login_view.dart';
import 'features/home/presentation/view/home_view.dart';
import 'features/profile/presentation/view/profile_view.dart';
import 'features/profile/presentation/view/widgets/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: LoginView(),
    );
  }
}



