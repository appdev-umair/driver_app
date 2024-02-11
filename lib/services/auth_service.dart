import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String baseUrl = 'http://localhost:5000';

  // Method to check if the user is logged in
  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // Method to save login status
  static Future<void> saveLoginStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, isLoggedIn);
  }
}
