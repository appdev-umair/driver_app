import 'package:driver_app/presentation/lead_screen/lead_screen.dart';
import 'package:driver_app/presentation/log_in_screen/log_in_screen.dart';
import 'package:driver_app/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      title: 'Your App',
      home: FutureBuilder<bool>(
        future: _checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.data == true) {
            return const LeadScreen();
          } else {
            return const LogInScreen();
          }
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
