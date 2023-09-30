import 'dart:async';

import 'package:hike_navigator/constans/user_location.dart';
import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  final StreamController<UserLocation> _locationStreamController =
      StreamController<UserLocation>.broadcast();

  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  LocationService() {
    initGeolocator();
  }

  Future<void> requestPermission() async {
    var status = await location.requestPermission();
    if (status == PermissionStatus.granted) {
      initGeolocator();
    } else {}
  }

  Future<void> initGeolocator() async {
    location.onLocationChanged.listen((locationData) {
      _locationStreamController.add(UserLocation(
        latitude: locationData.latitude,
        longitude: locationData.longitude,
        speed: locationData.speed ?? 0,
        heading: locationData.heading ?? 0,
      ));
    });
  }

  void dispose() {
    _locationStreamController.close();
  }
}
