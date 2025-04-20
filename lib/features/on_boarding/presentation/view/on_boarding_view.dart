import 'package:flutter/material.dart';

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
                image: 'assets/on1.gif',
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
                image: 'assets/on2.gif',
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
                image: 'assets/on3.gif',
                title: 'Provide you a Report',
                description:
                'rack your performance and progress with detailed reports provided by AI technology',
                buttonText: 'NEXT',
                buttonAction: () {
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn);
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
              child: Text(
                buttonText,
                style: TextStyle(
                    color:Colors.black,
                    fontFamily: "Diphylleia",
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
