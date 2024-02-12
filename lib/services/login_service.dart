import 'dart:convert';
import 'package:driver_app/core/utils/constants.dart';
import 'package:http/http.dart' as http;

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

    if (response.statusCode == 200) {
      // Login successful
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }
}