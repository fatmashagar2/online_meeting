import 'package:flutter/material.dart';
import 'package:online_meeting/features/on_boarding/presentation/view/on_boarding_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../features/auth/presentation/view/login_view.dart';
import '../../../../features/home/presentation/view/home_view.dart';
import 'package:animated_text_kit/animated_text_kit.dart'; // أضف دي فوق مع الimports


class SplashViewModel {
  Future<void> navigateToAppropriatePage(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3)); // وقت مؤقت للشاشة

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (isFirstTime) {
      prefs.setBool('isFirstTime', false); // المرة الجاية مش هيدخل على الأون بوردنج
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingView()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    }
  }
}

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // تفعيل التنقل عند تحميل الـ Splash
    Future.microtask(() {
      SplashViewModel().navigateToAppropriatePage(context);
    });

    return Scaffold(
      backgroundColor: const Color(0xffFCFEFC),
      body: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontFamily: 'Fredericka_the_Great',
            fontSize: 40,
            color: Colors.black, // لو حابب تغير اللون
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'EDU FOCUS',
                speed: const Duration(milliseconds: 200), // سرعة الكتابة
              ),
            ],
            totalRepeatCount: 1, // متكررش
            pause: const Duration(milliseconds: 4000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ),
      ),
    );
  }
}