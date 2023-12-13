import 'dart:convert';

import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:http/http.dart' as http;

class MountainsService {
  String url = API().getURL();

  fetchMountains(String? keyword, int? provinceId) async {
    var token = API().getToken();

    try {
      var response = await http.get(
        Uri.parse(
            "$url/mountains?keyword=${keyword ?? ''}&provinceId=${provinceId ?? 0}"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      List<dynamic> result = jsonDecode(response.body)['data'];
      List<MountainsModel> mountains = result
          .map((e) => MountainsModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return mountains;
    } catch (e) {
      rethrow;
    }
  }
}
