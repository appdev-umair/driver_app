import 'package:driver_app/core/app_export.dart';
import 'package:flutter/material.dart';

class AppRoutes {

  static const String signUpScreen = '/sign_up_screen';

  static const String logInScreen = '/log_in_screen';

  static const String leadScreen = '/lead_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        signUpScreen: (context) => const SignUpScreen(),
        logInScreen: (context) => const LogInScreen(),
        leadScreen: (context) =>  const LeadScreen(),
        initialRoute: (context) => const LogInScreen(),
      };
}
