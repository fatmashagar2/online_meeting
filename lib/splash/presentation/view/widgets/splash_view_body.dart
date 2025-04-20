import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/themes/app_colors.dart';
import '../../../../../core/utils/image_paths.dart';
import '../../view_model/splash_view_model.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    SplashViewModel().navigateToAppropriatePage(context);
    return Scaffold(
     backgroundColor: Color(0xffFCFEFC),
      body:
          // Center(
          //   child: Image.asset(
          //     'assets/img10.jpg',
          //     width: 250,
          //     height: 250,
          //   ),
          // )
Center(child: Text("EDU FOCUS",style: TextStyle(fontFamily: 'Fredericka_the_Great',fontSize: 40),))
    );
  }
}
