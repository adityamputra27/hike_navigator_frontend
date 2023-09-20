import 'dart:convert';

import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:http/http.dart' as http;

class DestinationsService {
  String url = API().getURL();

  fetchDestinations() async {
    var token = API().getToken();
    var userId = API().getUserId();

    try {
      var response = await http.get(
        Uri.parse("$url/getActiveUser/$userId"),
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
