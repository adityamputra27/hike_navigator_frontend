import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  String baseURL = 'http://10.0.2.2:8000/api';

  Future postRequest(
      {required String route, required Map<String, String> payload}) async {
    String url = baseURL + route;
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
      print(e);
    }
  }
}
