import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class API {
  String baseURL = 'https://hike-navigator.dittmptrr27.com/api';

  String getURL() {
    return baseURL;
  }

  getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token').toString();
    return token;
  }

  Future postRequest(
      {required String route, required Map<String, String> payload}) async {
    String url = getURL() + route;
    try {
      return await http.post(
        Uri.parse(url),
        body: jsonEncode(payload),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
