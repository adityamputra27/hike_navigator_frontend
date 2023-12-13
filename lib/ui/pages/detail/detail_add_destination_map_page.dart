import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/constans/maps/main.dart';
import 'package:hike_navigator/models/cross_roads_model.dart';
import 'package:hike_navigator/models/marks_model.dart';
import 'package:hike_navigator/models/mountain_peaks_model.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:hike_navigator/models/posts_model.dart';
import 'package:hike_navigator/models/rivers_model.dart';
import 'package:hike_navigator/models/tracks_model.dart';
import 'package:hike_navigator/models/waterfalls_model.dart';
import 'package:hike_navigator/models/watersprings_model.dart';
import 'package:hike_navigator/services/location_service.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';

class DetailAddDestinationMapPage extends StatefulWidget {
  final MountainsModel mountain;
  const DetailAddDestinationMapPage({required this.mountain, super.key});

  @override
  State<DetailAddDestinationMapPage> createState() =>
      _DetailAddDestinationMapPageState();
}

class _DetailAddDestinationMapPageState
    extends State<DetailAddDestinationMapPage> {
  LocationData? _currentLocation;
  LocationService locationService = LocationService();
  Location location = Location();

  @override
  void dispose() {
    locationService.dispose();
    super.dispose();
  }

  @override
  void initState() {
    locationService.requestPermission();
    super.initState();
    location.onLocationChanged.listen((LocationData locationData) {
      setState(() {
        _currentLocation = locationData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<TracksModel> mountainTracks = widget.mountain.mountainTracks;
    List<MountainPeaksModel> mountainPeaks = widget.mountain.mountainPeaks;
    List<MarksModel> mountainMarks = widget.mountain.mountainMarks;
    List<WaterfallsModel> mountainWaterfalls =
        widget.mountain.mountainWaterfalls;
    List<WaterspringsModel> mountainWatersprings =
        widget.mountain.mountainWatersprings;
    List<RiversModel> mountainRivers = widget.mountain.mountainRivers;
    List<PostsModel> mountainPosts = widget.mountain.mountainPosts;
    List<CrossRoadsModel> mountainCrossRoads =
        widget.mountain.mountainCrossRoads;

    List<Marker> peakMarkers = [];
    List<Marker> markMarkers = [];
    List<Marker> waterfallMarkers = [];
    List<Marker> waterspringMarkers = [];
    List<Marker> riverMarkers = [];
    List<Marker> postMarkers = [];
    List<Marker> crossRoadMarkers = [];

    for (var peak in mountainPeaks) {
      Marker peakMarker = Marker(
        width: 50,
        height: 50,
        point: LatLng(
          double.parse(peak.peak.latitude),
          double.parse(peak.peak.longitude),
        ),
        builder: (context) => Image.asset('assets/images/mountain_marker.png'),
      );
      peakMarkers.add(peakMarker);
    }

    for (var mark in mountainMarks) {
      Marker markMarker = Marker(
        width: 35,
        height: 35,
        point: LatLng(
          double.parse(mark.latitude),
          double.parse(mark.longitude),
        ),
        builder: (context) => Image.asset('assets/images/mark_marker.png'),
      );
      markMarkers.add(markMarker);
    }

    for (var waterfall in mountainWaterfalls) {
      Marker waterfallMarker = Marker(
        width: 35,
        height: 35,
        point: LatLng(
          double.parse(waterfall.latitude),
          double.parse(waterfall.longitude),
        ),
        builder: (context) => Image.asset('assets/images/waterfall_marker.png'),
      );
      waterfallMarkers.add(waterfallMarker);
    }

    for (var waterspring in mountainWatersprings) {
      Marker waterspringMarker = Marker(
        width: 35,
        height: 35,
        point: LatLng(
          double.parse(waterspring.latitude),
          double.parse(waterspring.longitude),
        ),
        builder: (context) => Image.asset('assets/images/water_marker.png'),
      );
      waterspringMarkers.add(waterspringMarker);
    }

    for (var river in mountainRivers) {
      Marker riverMarker = Marker(
        width: 35,
        height: 35,
        point: LatLng(
          double.parse(river.latitude),
          double.parse(river.longitude),
        ),
        builder: (context) => Image.asset('assets/images/wave_marker.png'),
      );
      riverMarkers.add(riverMarker);
    }

    for (var post in mountainPosts) {
      Marker postMarker = Marker(
        width: 35,
        height: 35,
        point: LatLng(
          double.parse(post.latitude),
          double.parse(post.longitude),
        ),
        builder: (context) => Image.asset('assets/images/camp_marker.png'),
      );
      postMarkers.add(postMarker);
    }

    for (var crossRoad in mountainCrossRoads) {
      Marker crossRoadMarker = Marker(
        width: 35,
        height: 35,
        point: LatLng(
          double.parse(crossRoad.latitude),
          double.parse(crossRoad.longitude),
        ),
        builder: (context) =>
            Image.asset('assets/images/cross_road_marker.png'),
      );
      crossRoadMarkers.add(crossRoadMarker);
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          StreamBuilder(
            stream: locationService.locationStream,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return FlutterMap(
                  options: MapOptions(
                    minZoom: 1,
                    maxZoom: 14,
                    zoom: 14,
                    center: LatLng(
                      double.parse(widget.mountain.latitude),
                      double.parse(widget.mountain.longitude),
                    ),
                  ),
                  nonRotatedChildren: [
                    TileLayer(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/hikenavigatornew/cllhutmqy017e01pb2626daaw/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGlrZW5hdmlnYXRvcm5ldyIsImEiOiJjbGxoZXRsdnoxOW5wM2ZwamZ2eTBtMWV1In0.jYkxsonNQIn_GsbJorNkEw',
                      additionalOptions: const {
                        'mapStyleId': MapConstant.mapBoxStyleID,
                        'accessToken': MapConstant.mapBoxAccessToken,
                      },
                    ),
                    PolylineLayer(
                      polylines: mountainTracks.map((track) {
                        List<dynamic> coordinates =
                            jsonDecode(track.coordinates);
                        List<LatLng> points = coordinates
                            .map((coord) => LatLng(coord[1], coord[0]))
                            .toList();

                        return Polyline(
                          points: points,
                          color: whiteColor,
                          strokeWidth: 3,
                          isDotted: true,
                        );
                      }).toList(),
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 35,
                          height: 35,
                          point: LatLng(
                            _currentLocation?.latitude ?? 0.0,
                            _currentLocation?.longitude ?? 0.0,
                          ),
                          builder: (context) =>
                              Image.asset('assets/images/user_marker.png'),
                        ),
                        Marker(
                          width: 50,
                          height: 50,
                          point: LatLng(
                            double.parse(widget.mountain.latitude),
                            double.parse(widget.mountain.longitude),
                          ),
                          builder: (context) {
                            return GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   mountainPopup = true;
                                // });
                              },
                              child: Image.asset(
                                  'assets/images/mountain_marker.png'),
                            );
                          },
                        ),
                        ...peakMarkers,
                        ...waterfallMarkers,
                        ...waterspringMarkers,
                        ...riverMarkers,
                        ...postMarkers,
                      ],
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 40,
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
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
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<LatLng> decodePolyline(String encoded) {
    List<LatLng> points = PolylinePoints()
        .decodePolyline(encoded)
        .map((PointLatLng point) => LatLng(point.latitude, point.longitude))
        .toList();
    return points;
  }
}
