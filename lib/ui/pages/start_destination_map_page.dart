import 'dart:convert';
import 'dart:math';

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
  String mountainMarker = 'assets/images/mountain_marker.png';
  String campMarker = 'assets/images/camp_marker.png';
  String markMarker = 'assets/images/mark_marker.png';
  String waterfallMarker = 'assets/images/waterfall_marker.png';
  String waterspringMarker = 'assets/images/water_marker.png';
  String riverMarker = 'assets/images/wave_marker.png';
  String startMarker = 'assets/images/start.png';

  dynamic symbolData;
  bool showMarkerDialog = false;

  void _onMapCreated(MaplibreMapController controller) async {
    mapController = controller;
    mapController?.onSymbolTapped.add(_onMarkerTapped);
  }

  void _onStyleLoaded() {
    _loadImageAsset();
    _loadMarkerImage();
  }

  void _loadImageAsset() {
    addImageFromAsset('assetImage', mountainMarker);
    addImageFromAsset('assetImage', campMarker);
    addImageFromAsset('assetImage', markMarker);
    addImageFromAsset('assetImage', waterfallMarker);
    addImageFromAsset('assetImage', waterspringMarker);
    addImageFromAsset('assetImage', riverMarker);
    addImageFromAsset('assetImage', startMarker);
  }

  void _loadMarkerImage() {
    _addMarkerImage(
      startMarker,
      LatLng(
        double.parse(widget.destination.track.startLatitude),
        double.parse(widget.destination.track.startLongitude),
      ),
      {
        'title': 'Start Point',
        'latitude': widget.destination.track.startLatitude,
        'longitude': widget.destination.track.startLongitude,
      },
    );
    _addMarkerImage(
      mountainMarker,
      LatLng(
        double.parse(widget.destination.mountain.latitude),
        double.parse(widget.destination.mountain.longitude),
      ),
      {
        'title': widget.destination.mountain.name,
        'latitude': widget.destination.mountain.latitude,
        'longitude': widget.destination.mountain.longitude,
      },
    );
    _addMarkerImage(
      mountainMarker,
      LatLng(
        double.parse(widget.destination.mountainPeak.peak.latitude),
        double.parse(widget.destination.mountainPeak.peak.longitude),
      ),
      {
        'title': widget.destination.mountainPeak.peak.name,
        'latitude': widget.destination.mountainPeak.peak.latitude,
        'longitude': widget.destination.mountainPeak.peak.longitude,
      },
    );
    for (var camp in widget.destination.mountain.mountainPosts) {
      _addMarkerImage(
        campMarker,
        LatLng(
          double.parse(camp.latitude),
          double.parse(camp.longitude),
        ),
        {
          'title': camp.title,
          'latitude': camp.latitude,
          'longitude': camp.longitude,
        },
      );
    }
    for (var mark in widget.destination.mountain.mountainMarks) {
      _addMarkerImage(
        markMarker,
        LatLng(
          double.parse(mark.latitude),
          double.parse(mark.longitude),
        ),
        {
          'title': mark.title,
          'latitude': mark.latitude,
          'longitude': mark.longitude,
        },
      );
    }
    for (var waterfall in widget.destination.mountain.mountainWaterfalls) {
      _addMarkerImage(
        waterfallMarker,
        LatLng(
          double.parse(waterfall.latitude),
          double.parse(waterfall.longitude),
        ),
        {
          'title': waterfall.title,
          'latitude': waterfall.latitude,
          'longitude': waterfall.longitude,
        },
      );
    }
    for (var waterspring in widget.destination.mountain.mountainWatersprings) {
      _addMarkerImage(
        waterspringMarker,
        LatLng(
          double.parse(waterspring.latitude),
          double.parse(waterspring.longitude),
        ),
        {
          'title': waterspring.title,
          'latitude': waterspring.latitude,
          'longitude': waterspring.longitude,
        },
      );
    }
    for (var river in widget.destination.mountain.mountainRivers) {
      _addMarkerImage(
        riverMarker,
        LatLng(
          double.parse(river.latitude),
          double.parse(river.longitude),
        ),
        {
          'title': river.title,
          'latitude': river.latitude,
          'longitude': river.longitude,
        },
      );
    }
    for (var track in widget.destination.mountain.mountainTracks) {
      List<dynamic> coordinates = jsonDecode(track.coordinates);
      List<LatLng> points =
          coordinates.map((coord) => LatLng(coord[1], coord[0])).toList();
      _addLine(points);
    }
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController?.addImage(name, list);
  }

  void _addMarkerImage(String iconImage, LatLng location, dynamic data) {
    mapController?.addSymbol(
      _getImageSymbolOptions(iconImage, location),
      data,
    );
  }

  void _addLine(List<LatLng> locationList) {
    mapController?.addLine(
      LineOptions(
        geometry: locationList,
        lineColor: '#ffffff',
        lineWidth: 3,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  SymbolOptions _getImageSymbolOptions(String iconImage, LatLng location) {
    return SymbolOptions(
      geometry: location,
      iconImage: iconImage,
      iconSize: 1,
    );
  }

  void _onMarkerTapped(Symbol symbol) {
    setState(() {
      showMarkerDialog = false;
    });

    setState(() {
      symbolData = symbol.data;
      showMarkerDialog = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildMap(),
      ),
      floatingActionButton: floatingMap(),
    );
  }

  Row floatingMap() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 65,
              height: 65,
              margin: const EdgeInsets.only(left: 30),
              child: FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () {
                  mapController?.animateCamera(CameraUpdate.zoomIn());
                },
                child: Icon(
                  Icons.add_location_alt_outlined,
                  size: 30,
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 65,
              height: 65,
              child: FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () {
                  mapController?.animateCamera(CameraUpdate.zoomIn());
                },
                child: Icon(
                  Icons.zoom_in,
                  size: 30,
                  color: whiteColor,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 65,
              height: 65,
              child: FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () {
                  mapController?.animateCamera(CameraUpdate.zoomOut());
                },
                child: Icon(
                  Icons.zoom_out,
                  size: 30,
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Stack buildMap() {
    return Stack(
      children: [
        MaplibreMap(
          styleString: widget.offlineMap.definition.mapStyleUrl,
          onMapCreated: _onMapCreated,
          onStyleLoadedCallback: _onStyleLoaded,
          myLocationEnabled: true,
          myLocationRenderMode: MyLocationRenderMode.GPS,
          myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              double.parse(widget.destination.track.startLatitude),
              double.parse(widget.destination.track.startLongitude),
            ),
            zoom: 13.5,
          ),
          trackCameraPosition: true,
          onMapClick: (Point<double> point, LatLng coordinates) {
            setState(() {
              showMarkerDialog = false;
            });
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 15,
          height: 80,
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Current route',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: black,
                            color: blackColor,
                          ),
                        ),
                        Text(
                          "${widget.destination.mountain.name}, ${widget.destination.mountain.province.name}",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: medium,
                            color: blackColor,
                          ),
                        ),
                      ],
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
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          left: 0,
          right: 0,
          bottom: showMarkerDialog ? 15 : -150,
          height: 120,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      symbolData['title'].toString(),
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: black,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Latitude : ${symbolData['latitude']}",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: medium,
                        color: blackColor,
                      ),
                    ),
                    Text(
                      "Longitude : ${symbolData['longitude']}",
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: medium,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
