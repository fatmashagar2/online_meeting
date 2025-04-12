import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_meeting/features/chat/presentation/view/chat_view.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.txt, required this.isIconVisible})
      : super(key: key);

  final String txt;
  final bool isIconVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff092147), Color(0xff1E54A6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xff1E54A6).withOpacity(0.5),
            blurRadius: 8.8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: Color(0xff1E54A6),
            width: 0.5.w,  // استخدم ScreenUtil لقياس العرض
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // أيقونة الرجوع
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
          // نص العنوان
          Text(
            txt,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Diphylleia',
            ),
          ),
          // أيقونة المسنجر
          Visibility(
            visible: isIconVisible,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatView(),
                  ),
                );
              },
              icon: const Icon(
                FontAwesomeIcons.facebookMessenger,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // تحديد حجم الـ AppBar بناءً على الشاشة
  @override
  Size get preferredSize => Size.fromHeight(100.h); // استخدام ScreenUtil لتحديد الارتفاع
}
