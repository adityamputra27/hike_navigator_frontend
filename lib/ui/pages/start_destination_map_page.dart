import 'package:flutter/material.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:maplibre_gl/mapbox_gl.dart';

class StartDestinationMapPage extends StatefulWidget {
  final DestinationsModel destination;
  final OfflineRegion offlineMap;
  const StartDestinationMapPage({
    required this.destination,
    required this.offlineMap,
    super.key,
  });

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
              styleString: widget.offlineMap.definition.mapStyleUrl,
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
