import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:hike_navigator/services/location_service.dart';
import 'package:hike_navigator/ui/pages/main_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String checkPointMarker = 'assets/images/check_point.png';
  String mountainMarker = 'assets/images/mountain_marker.png';
  String campMarker = 'assets/images/camp_marker.png';
  String markMarker = 'assets/images/mark_marker.png';
  String waterfallMarker = 'assets/images/waterfall_marker.png';
  String waterspringMarker = 'assets/images/water_marker.png';
  String riverMarker = 'assets/images/wave_marker.png';
  String startMarker = 'assets/images/start.png';

  dynamic symbolData;
  bool showMarkerDialog = false;
  LocationService locationService = LocationService();
  bool isOnline = false;

  void _onMapCreated(MaplibreMapController controller) async {
    mapController = controller;
    mapController?.onSymbolTapped.add(_onMarkerTapped);
  }

  void _onStyleLoaded() {
    _loadImageAsset();
    _loadMarkerImage();
    _loadMarkersFromStorage();
  }

  void _loadMarkersFromStorage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? checkPoints =
        preferences.getStringList('CHECK_POINTS_${widget.offlineMap.id}');
    if (checkPoints != null) {
      for (String checkPoint in checkPoints) {
        dynamic checkPointData = jsonDecode(checkPoint);
        _addMarkerImage(
          checkPointMarker,
          LatLng(double.parse(checkPointData['latitude']),
              double.parse(checkPointData['longitude'])),
          checkPointData,
          0.25,
        );
      }
    }
  }

  void _loadImageAsset() {
    addImageFromAsset('assetImage', checkPointMarker);
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
        'contactNumber': '-',
        'height': '0',
      },
      0.5,
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
        'contactNumber': '-',
        'height': widget.destination.mountain.height,
      },
      0.5,
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
        'contactNumber': '-',
        'height': widget.destination.mountainPeak.peak.height,
      },
      0.5,
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
          'contactNumber': camp.contactNumber,
          'height': '0',
        },
        0.5,
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
          'contactNumber': mark.contactNumber,
          'height': '0',
        },
        0.25,
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
          'contactNumber': waterfall.contactNumber,
          'height': '0',
        },
        0.5,
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
          'contactNumber': waterspring.contactNumber,
          'height': '0',
        },
        0.5,
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
          'contactNumber': river.contactNumber,
          'height': '0',
        },
        0.5,
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

  void _addMarkerImage(
      String iconImage, LatLng location, dynamic data, double size) {
    mapController?.addSymbol(
      _getImageSymbolOptions(iconImage, location, size),
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
    locationService.requestPermission();
    checkConnection();
    super.initState();
  }

  Future checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty) {
        setState(() {
          isOnline = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isOnline = false;
      });
    }
  }

  SymbolOptions _getImageSymbolOptions(
      String iconImage, LatLng location, double size) {
    return SymbolOptions(
      geometry: location,
      iconImage: iconImage,
      iconSize: size,
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

  void _saveCheckPoint(String locationTitle, LatLng markerLocation) async {
    dynamic payload = {
      'title': locationTitle,
      'latitude': markerLocation.latitude.toString(),
      'longitude': markerLocation.longitude.toString(),
      'contactNumber': '-',
      'height': '0',
    };

    _addMarkerImage(checkPointMarker, markerLocation, payload, 0.25);
    _saveCheckPointData(payload);
  }

  void _saveCheckPointData(dynamic data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> checkPoints =
        preferences.getStringList('CHECK_POINTS_${widget.offlineMap.id}') ?? [];
    checkPoints.add(jsonEncode(data));
    await preferences.setStringList(
        'CHECK_POINTS_${widget.offlineMap.id}', checkPoints);
  }

  Future<void> _showDialog(
      String text, String status, Function() onPressed) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defaultRadius,
            ),
          ),
          icon: Image.asset(
            status == 'success'
                ? 'assets/images/check_icon.png'
                : 'assets/images/failed_icon.png',
            width: 45,
            height: 45,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                text.toString(),
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
                child: Text(
                  'OK',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: whiteColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void finishDestination() async {
    if (isOnline == true) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final result = await API().postRequestWithToken(
        route: '/climbing-plans/${widget.destination.id}/finish',
        payload: {},
      );

      final response = jsonDecode(result.body);

      if (response['status'] == 400) {
        preferences.remove('OFFLINE_DESTINATION_${widget.offlineMap.id}');
        preferences.remove('OFFLINE_DESTINATION_IMAGE_${widget.offlineMap.id}');
        preferences.remove('CHECK_POINTS_${widget.offlineMap.id}');

        _showDialog(
          response['message'],
          'success',
          () => {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MainPage(
                  preferences: preferences,
                ),
              ),
              (Route route) => false,
            ),
          },
        );
      } else {
        _showDialog(
          response['message'],
          'failed',
          () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => MainPage(
                preferences: preferences,
              ),
            ),
            (Route route) => false,
          ),
        );
      }
    } else {
      _showDialog(
        'No internet connection',
        'failed',
        () => Navigator.pop(context),
      );
    }
  }

  Future<String?> _showDialogCheckPoint(BuildContext context) async {
    TextEditingController controller = TextEditingController();
    return showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: Text(
            'Add Check Point :',
            style: GoogleFonts.inter(
              fontSize: 18,
              color: blackColor,
              fontWeight: bold,
            ),
          ),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'Title',
              labelStyle: GoogleFonts.inter(
                fontSize: 14,
                color: blackColor,
                fontWeight: medium,
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: greyColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      color: whiteColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                TextButton(
                  onPressed: () {
                    String locationTitle = controller.text;
                    Navigator.of(context).pop(locationTitle);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
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
                onPressed: () async {
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  LatLng markerLocation =
                  LatLng(position.latitude, position.longitude);
                  String? locationTitle =
                  // ignore: use_build_context_synchronously
                  await _showDialogCheckPoint(context);
                  if (locationTitle != null && locationTitle.isNotEmpty) {
                    _saveCheckPoint(locationTitle, markerLocation);
                  }
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
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 65,
              height: 65,
              child: FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: finishDestination,
                child: Icon(
                  Icons.check_circle_outline,
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
          compassEnabled: false,
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
            tilt: 0,
          ),
          minMaxZoomPreference: const MinMaxZoomPreference(12, 15),
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
          bottom: showMarkerDialog ? 30 : -150,
          height: 145,
          child: PageView.builder(
            itemBuilder: (_, index) {
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                        bottom: 20,
                      ),
                      padding: const EdgeInsets.only(
                        left: 25,
                        right: 25,
                        top: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25,
                        ),
                        color: whiteColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(3, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            symbolData['title'].toString(),
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: black,
                              color: blackColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            '${symbolData['height'].toString()} mdpl',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: bold,
                              color: primaryColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Contact Number : ${symbolData['contactNumber'] != '' ? symbolData['contactNumber'].toString() : '-'}',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: medium,
                              color: blackColor,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: SizedBox(),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
