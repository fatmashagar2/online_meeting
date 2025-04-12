import 'package:flutter/material.dart';
import 'package:online_meeting/features/profile/presentation/view/widgets/log_out_dialog.dart';
import 'package:provider/provider.dart';

import '../../../../core/localization/app_localization.dart';
import '../../../../core/themes/theme_provider.dart';
import '../../../home/presentation/view/home_view.dart';
import '../view_model/language_provider.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // 🔹 استدعاء ThemeProvider
    String currentLocale = Localizations.localeOf(context).languageCode;
    bool isArabic = currentLocale == 'ar'; // التحقق إذا كانت اللغة عربية
    return Scaffold(
      body: SingleChildScrollView(
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
                alignment:
                    isArabic ? Alignment.bottomLeft : Alignment.bottomRight,
                child: Text(
                  AppLocalizations.of(context)!.translate('edit_profile'),
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
              'x@gmail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 30),
            Divider(),

            ListTile(
                trailing: Icon(Icons.logout),
                title: Text(

                  'Logout',
                  style: TextStyle(
                    fontSize: 15,
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                     ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return LogOutDialog();
                    },
                  );
                }),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.translate('language'),
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              trailing: Icon(Icons.language_outlined),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(AppLocalizations.of(context)!
                          .translate('choose_language')),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('English'),
                            onTap: () {
                              Provider.of<LanguageProvider>(context,
                                      listen: false)
                                  .changeLanguage('en');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('العربية'),
                            onTap: () {
                              Provider.of<LanguageProvider>(context,
                                      listen: false)
                                  .changeLanguage('ar');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            ListTile(
              title: Text(
                AppLocalizations.of(context)!.translate('dark_mode'),
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              trailing: Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
