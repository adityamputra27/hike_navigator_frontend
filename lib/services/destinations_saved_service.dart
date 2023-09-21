import 'dart:convert';

import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DestinationsSavedService {
  String url = API().getURL();

  fetchDestinationsSaved() async {
    var token = API().getToken();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? userId = preferences.getInt('user_id');

    try {
      var response = await http.get(
        Uri.parse("$url/climbing-plans/getSavedUser/$userId"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      List<dynamic> result = jsonDecode(response.body)['data'];

      List<DestinationsModel> destinationsSaved = result
          .map((e) => DestinationsModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return destinationsSaved;
    } catch (e) {
      rethrow;
    }
  }
}
