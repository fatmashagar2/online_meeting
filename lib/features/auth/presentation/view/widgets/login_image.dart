import 'package:flutter/material.dart';

class LoginImage extends StatelessWidget {
  final double topPadding;
  const LoginImage({Key? key, required this.topPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Center(
        child: Image.asset(
          'assets/on2.gif',
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
