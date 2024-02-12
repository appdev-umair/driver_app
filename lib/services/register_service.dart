import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:driver_app/core/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart'; // Import for MediaType
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationService {
  static Future<bool> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String socialSecurity,
    required String licenseNumber,
    required String dob,
    required String password,
    required String role,
    required String address,
    required FilePickerResult? fileData,
    required String fileName,
  }) async {
    final String registerUrl = '${Constant.baseUrl}/api/v1/user/register';
    final Map<String, String> body = {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'socialSecurity': socialSecurity,
      'licenseNumber': licenseNumber,
      'dob': dob,
      'password': password,
      'role': role,
      'address': address,
    };

    try {
      var dio = Dio();

      if (fileData != null) {
        Uint8List? bytes = fileData.files.single.bytes;

        // Get MIME type using the mime_type package
        String? mimeType = mime(fileName);

        // Ensure MIME type is available, handle potential errors
        if (mimeType != null) {
          MediaType? contentType = MediaType.parse(mimeType);

          if (bytes != null) {
            MultipartFile drivingLicense = MultipartFile.fromBytes(bytes,
                filename: fileName, contentType: contentType);

            FormData data = FormData.fromMap({
              ...body,
              "driving_license": drivingLicense,
            });

            var response = await dio.post(registerUrl, data: data);

            if (response.statusCode == 201 || response.statusCode == 200) {
              // Parse the response
              Map<String, dynamic> jsonResponse = response.data;
              String token = jsonResponse['token'];
              print(token);
              // Store the token using shared preferences
              await _saveToken(token);

              return true;
            }
          }
        } else {
          print("Error: Could not determine MIME type of the file.");
          // Handle the error, e.g., inform the user or try alternative methods
        }
      }
    } catch (e) {
      print(e);
    }

    return false; // Adjust return value based on success or failure
  }

  static Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }
}
