import 'dart:convert';
import 'package:driver_app/core/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogInService {
  static Future<bool> login(String phone, String password) async {
    String loginUrl = '${Constant.baseUrl}/api/v1/user/login';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, String> body = {'phone': phone, 'password': password};
    final http.Response response = await http.post(
      Uri.parse(loginUrl),
      headers: headers,
      body: jsonEncode(body),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // Parse the response
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String token = jsonResponse['token'];
      String userId = jsonResponse['user']['_id'];

      // Store the token and user ID using shared preferences
      await _saveTokenAndUserId(token, userId);

      // Login successful
      return true;
    } else {
      return false;
    }
  }

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.setBool('isLoggedIn', false);
  }

  static Future<void> _saveTokenAndUserId(String token, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
    await prefs.setString('userId', userId);
  }
}
