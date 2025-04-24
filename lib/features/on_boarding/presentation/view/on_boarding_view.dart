import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../auth/presentation/view/login_view.dart';

class OnboardingView extends StatelessWidget {
  final PageController _pageController = PageController();

  OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: <Widget>[
              buildPage(
                image: 'assets/82a5b870b79524369da915857971fa6e.gif',
                title: 'Welcome to EDU Focus',
                description:
                'We provide you with a unique educational experience through online meetings',
                buttonText: 'Next',
                buttonAction: () {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
              ),
              buildPage(
                image: 'assets/Hope For Tomorrow.gif',
                title: 'Increases concentration',
                description:
                'Our app uses advanced technology to measure students concentration levels during lessons through their interactions and responses',
                buttonText: 'Next',
                buttonAction: () {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
                },
              ),
              buildPage(
                image: 'assets/876f9c5858d664d0efa0c476db65ef87.gif',
                title: 'Provide you a Report',
                description:
                'rack your performance and progress with detailed reports provided by AI technology',
                buttonText: 'Next',
                buttonAction: () {
                  finishOnboarding(context);
                },

              ),
            ],
          ),
          Positioned(
            top: 40,
            child: TextButton(
              onPressed: () {
                // to login
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                    fontFamily: 'Diphylleia',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage({
    required String image,
    required String title,
    required String description,
    required String buttonText,
    required VoidCallback buttonAction,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(image, height: 300),
          const SizedBox(height: 32),
          Text(
            title,
            style: const TextStyle(
                fontSize: 24,
                color:Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "Diphylleia"),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color:Colors.black,),
          ),
          const SizedBox(height: 32),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: buttonAction,
              child: Text(
                buttonText,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Diphylleia",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }

  void finishOnboarding(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false); // مهم جدًا
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>  LoginView()),
    );
  }
}