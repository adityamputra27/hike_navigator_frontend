import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

class StartDestinationMapPage extends StatefulWidget {
  final MountainsModel mountain;
  const StartDestinationMapPage({required this.mountain, super.key});

  @override
  State<StartDestinationMapPage> createState() =>
      _StartDestinationMapPageState();
}

class _StartDestinationMapPageState extends State<StartDestinationMapPage> {
  MaplibreMapController? mapController;

  void _onMapCreated(MaplibreMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MaplibreMap(
              styleString:
                  'https://tiles.stadiamaps.com/styles/outdoors.json?api_key=8b9c5db3-b674-43f3-8e62-79e5936a6b2f',
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              myLocationRenderMode: MyLocationRenderMode.GPS,
              myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
              initialCameraPosition: const CameraPosition(
                target: LatLng(-6.820762, 107.142960),
                zoom: 14,
              ),
              trackCameraPosition: true,
            ),
          ],
        ),
      ),
    );
  }
}
