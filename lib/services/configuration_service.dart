import 'dart:convert';

import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/province_model.dart';
import 'package:http/http.dart' as http;

class ConfigurationService {
  String url = API().getURL();

  fetchProvinces() async {
    var token = API().getToken();

    try {
      var response = await http.get(
        Uri.parse("$url/configuration/getActiveProvinces"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      List<dynamic> result = jsonDecode(response.body)['data'];
      List<ProvinceModel> provinces = result
          .map((e) => ProvinceModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return provinces;
    } catch (e) {
      rethrow;
    }
  }
}
