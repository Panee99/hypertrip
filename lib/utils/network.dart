import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkUtility {
  static Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Xóa dữ liệu thất bại. Mã phản hồi: ${response.statusCode}');
      }
    } catch (e) {
      print("fetchUrl ${e.toString()}");
    }
    return null;
  }

  static Future<String?> post(Uri uri, {Map<String, String>? headers, String? body}) async {
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

  static Future<String?> uploadFile(
    Uri uri, {
    Map<String, String>? headers,
    required String path,
  }) async {
    try {
      var request = http.MultipartRequest('POST', uri);
      request.files.add(await http.MultipartFile.fromPath('file', path));
      if (headers != null) request.headers.addAll(headers);
      var response = await request.send();

      if (response.statusCode == 200) {
        return response.stream.bytesToString();
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
    return null;
  }

  Future<String?> deleteData(Uri uri) async {
    try {
      final response = await http.delete(uri);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Xóa dữ liệu thất bại. Mã phản hồi: ${response.statusCode}');
      }
    } catch (error) {
      return null;
    }
    return null;
  }
}
