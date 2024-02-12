import 'dart:convert';
import 'package:driver_app/core/utils/constants.dart';
import 'package:driver_app/model/leads_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LeadsService {
  static Future<List<Lead>> getAllLeads(String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var driverId = prefs.getString('userId');
    String url = "";
    if (status.isEmpty) {
      url = '${Constant.baseUrl}/api/v1/lead/all-leads';
    } else {
      url =
          '${Constant.baseUrl}/api/v1/lead/all-leads?driver=$driverId&status=$status';
      print(url);
    }
    String? token = await _getToken();
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);

        List<Lead> leads = (responseData['leads'] as List)
            .map((leadJson) => Lead.fromJson(leadJson))
            .toList();
        return leads;
      } else {
        throw Exception('Failed to load leads');
      }
    } catch (e) {
      throw Exception('Failed to load leads: $e');
    }
  }

  static Future<bool> requestLead(String leadId) async {
    try {
      String? token = await _getToken();

      final url = Uri.parse('${Constant.baseUrl}/api/v1/lead/request-lead');
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: '{"leadId": "$leadId"}',
      );
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        // Request failed
        print('Failed to request lead. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Exception occurred
      print('Error requesting lead: $e');
      return false;
    }
  }

  static Future<bool> markLeadAsCompleted(String leadId) async {
    final String markCompletedUrl =
        '${Constant.baseUrl}/api/v1/lead/complete-lead';
    String? token = await _getToken();

    try {
      final http.Response response = await http.patch(
        Uri.parse(markCompletedUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'leadId': leadId}),
      );

      if (response.statusCode == 200) {
        // Lead marked as completed successfully
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false; // Adjust return value based on success or failure
  }

  static Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
