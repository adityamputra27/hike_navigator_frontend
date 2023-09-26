import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/constans/maps/main.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class DetailAddDestinationMapPage extends StatefulWidget {
  final MountainsModel mountain;
  const DetailAddDestinationMapPage({required this.mountain, super.key});

  @override
  State<DetailAddDestinationMapPage> createState() =>
      _DetailAddDestinationMapPageState();
}

class _DetailAddDestinationMapPageState
    extends State<DetailAddDestinationMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              minZoom: 5,
              maxZoom: 18,
              zoom: 10,
              center: MapConstant.defaultLocation,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/hikenavigatornew/cllhutmqy017e01pb2626daaw/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiaGlrZW5hdmlnYXRvcm5ldyIsImEiOiJjbGxoZXRsdnoxOW5wM2ZwamZ2eTBtMWV1In0.jYkxsonNQIn_GsbJorNkEw',
                additionalOptions: const {
                  'mapStyleId': MapConstant.mapBoxStyleID,
                  'accessToken': MapConstant.mapBoxAccessToken,
                },
              ),
            ],
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
}
