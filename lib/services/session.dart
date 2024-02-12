import 'dart:convert';

import 'package:dio/dio.dart';

class Session {
  Map<String, String> headers = {};
  // GET request with Dio
  Future<Response> get(String url) async {
    final dio = Dio();
    dio.options.extra['withCredentials'] = true;
    final response = await dio.get(url);
    return response;
  }

  // POST request with Dio
  Future<Response> post(String url, Map<String, String> body) async {
    final dio = Dio();

    final response = await dio.post(url, data: jsonEncode(body));
    return response;
  }
}
