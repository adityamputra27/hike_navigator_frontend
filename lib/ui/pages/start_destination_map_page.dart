import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
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

  Future<Uint8List> loadMarkerImage() async {
    var byteData = await rootBundle.load('assets/images/mountain_marker.png');
    return byteData.buffer.asUint8List();
  }

  void _onMapCreated(MaplibreMapController controller) async {
    mapController = controller;

    var markerImage = await loadMarkerImage();

    controller.addImage('marker', markerImage);

    controller.addSymbol(
      SymbolOptions(
        iconImage: 'marker',
        iconSize: 2,
        geometry: LatLng(
          double.parse(widget.destination.mountain.latitude),
          double.parse(widget.destination.mountain.longitude),
        ),
      ),
    );
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
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  double.parse(widget.destination.mountain.latitude),
                  double.parse(widget.destination.mountain.longitude),
                ),
                zoom: 10,
              ),
              trackCameraPosition: true,
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 15,
              height: 65,
              child: PageView.builder(
                itemBuilder: (_, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      color: whiteColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: redAccentColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: whiteColor,
                            ),
                          ),
                        ),
                        Text(
                          'Current route',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: black,
                            color: blackColor,
                          ),
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: redAccentColor,
                            borderRadius: BorderRadius.circular(defaultRadius),
                          ),
                          child: Icon(
                            Icons.compass_calibration,
                            color: whiteColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
