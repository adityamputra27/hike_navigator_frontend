import 'dart:convert';

import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DestinationsService {
  String url = API().getURL();

  fetchDestinations(String? keyword, int? provinceId) async {
    var token = API().getToken();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userId = preferences.getInt('user_id');

    try {
      var response = await http.get(
        Uri.parse(
            "$url/climbing-plans/getActiveUser/$userId?keyword=${keyword ?? ''}&provinceId=${provinceId ?? 0}"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      List<dynamic> result = jsonDecode(response.body)['data'];
      List<DestinationsModel> destinations = result
          .map((e) => DestinationsModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return destinations;
    } catch (e) {
      rethrow;
    }
  }
}
