import 'dart:convert';
import 'package:driver_app/services/auth_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:5000';

  static Future<bool> login(String phone, String password) async {
    const String loginUrl = '$baseUrl/api/v1/user/login';
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    final Map<String, String> body = {'phone': phone, 'password': password};
    print("Umair");
    final http.Response response = await http.post(
      Uri.parse(loginUrl),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // Login successful
      return true;
    } else {
      print("kam hi sahi tery");
      return false;
    }
  }

  static Future<void> logout() async {
    // Clear authentication status when user logs out
    await AuthService.saveLoginStatus(false);
  }

  
Future<void> registerUser() async {
  var url = Uri.parse('{{BASE_URL}}/api/v1/user/register');

  var response = await http.post(
    url,
    headers: <String, String>{},
    body: {
      "firstName": "Usama",
      "lastName": "Bashir",
      "phone": "+923060854097",
      "socialSecurity": "Security",
      "licenseNumber": "LIC123",
      "dob": "1997-07-27T15:41:13.311Z",
      "password": "123456789",
      "driving_license": "path_to_your_image_file", // This needs to be replaced with the actual file path or a byte array of the image
      "role": "Driver",
      "address": "Gujrat, Punjab, Pakistan",
    },
  );

  if (response.statusCode == 200) {
    // Registration successful
    print('User registered successfully');
  } else {
    // Registration failed
    print('Failed to register user: ${response.body}');
  }
}
}
