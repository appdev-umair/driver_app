import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:driver_app/core/utils/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart'; // Import for MediaType

class RegistrationService {
  static const String baseUrl = '{{BASE_URL}}';

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
      FilePickerResult? result = await FilePicker.platform.pickFiles();
        print("object");
        print(result);
      if (result != null) {
        Uint8List? bytes = result.files.single.bytes;

        String fileName = result.files.single.name;

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
            print(response);
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
}
