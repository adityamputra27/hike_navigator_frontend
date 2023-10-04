import 'package:flutter/material.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
// import 'package:hike_navigator/services/location_service.dart';
// import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class StartDestinationMapPage extends StatefulWidget {
  final MountainsModel mountain;

  const StartDestinationMapPage({required this.mountain, super.key});

  @override
  State<StartDestinationMapPage> createState() =>
      _StartDestinationMapPageState();
}

class _StartDestinationMapPageState extends State<StartDestinationMapPage> {
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;

  @override
  void initState() {
    _initialCameraPosition =
        const CameraPosition(target: LatLng(-6.820762, 107.142960));
    checkAndRequestLocationPermission();
    super.initState();
  }

  Future<void> checkAndRequestLocationPermission() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData locationData = await location.getLocation();
  }

  _onMapCreated(MapboxMapController controller) async {
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        _initialCameraPosition,
      ),
    );

    // var markerImage = await loadIma
    // controller.addImage('marker', bytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MapboxMap(
          initialCameraPosition: _initialCameraPosition,
          accessToken:
              'pk.eyJ1IjoiaGlrZW5hdmlnYXRvcm5ldyIsImEiOiJjbGxoZXRsdnoxOW5wM2ZwamZ2eTBtMWV1In0.jYkxsonNQIn_GsbJorNkEw',
          onMapCreated: _onMapCreated,
          myLocationEnabled: true,
          myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
          myLocationRenderMode: MyLocationRenderMode.COMPASS,
          minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              _initialCameraPosition,
            ),
          );
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
