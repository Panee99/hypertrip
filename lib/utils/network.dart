import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkUtility {
  static Future<String?> fetchUrl(Uri uri,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

  static Future<String?> post(Uri uri,
      {Map<String, String>? headers, String? body}) async {
    try {
      final response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
