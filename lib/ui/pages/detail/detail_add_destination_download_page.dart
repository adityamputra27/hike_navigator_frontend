import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:hike_navigator/ui/pages/main_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class DetailAddDestinationDownloadPage extends StatefulWidget {
  final DestinationsModel destination;
  final MountainsModel mountain;
  const DetailAddDestinationDownloadPage({
    required this.mountain,
    required this.destination,
    super.key,
  });

  @override
  State<DetailAddDestinationDownloadPage> createState() =>
      _DetailAddDestinationDownloadPageState();
}

class _DetailAddDestinationDownloadPageState
    extends State<DetailAddDestinationDownloadPage> {
  double downloadProgress = 0.0;
  bool isDownloading = false;
  String? message;
  OfflineRegion? region;

  void _onDowloadEvent(DownloadRegionStatus status) async {
    if (!mounted) return;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (status is Success) {
      setState(() {
        downloadProgress = 1.0;
      });
      if ((downloadProgress * 100).round() == 100) {
        await _saveOfflineDestination(region);

        _showDialog(
          'Peta Offline Berhasil Di unduh!',
          'success',
          0,
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(
                preferences: preferences,
              ),
            ),
          ),
        );
      }
    } else if (status is InProgress) {
      setState(() {
        downloadProgress = status.progress / 100;
      });
    } else if (status is Error) {
      setState(() {
        isDownloading = false;
        _showDialog(
            'Gagal mengunduh Peta Offline. Silahkan coba lagi', 'error', 0, () {
          Navigator.pop(context);
          _downloadRegion();
        });
      });
    }
  }

  Future<void> _downloadRegion() async {
    if (isDownloading) return;
    setState(() {
      isDownloading = true;
    });

    final bounds = LatLngBounds(
      southwest: LatLng(
        double.parse(widget.mountain.latitude),
        double.parse(widget.mountain.longitude),
      ),
      northeast: LatLng(
        double.parse(widget.mountain.latitude),
        double.parse(widget.mountain.longitude),
      ),
    );

    final regionDefinition = OfflineRegionDefinition(
      bounds: bounds,
      mapStyleUrl:
          'https://tiles.stadiamaps.com/styles/outdoors.json?api_key=8b9c5db3-b674-43f3-8e62-79e5936a6b2f',
      minZoom: 6,
      maxZoom: 14,
    );

    final regions = await getListOfRegions();
    for (final region in regions) {
      if (region.definition.bounds == regionDefinition.bounds) {
        await deleteOfflineRegion(region.id);
        break;
      }
    }

    try {
      final downloadedRegion = await downloadOfflineRegion(
        regionDefinition,
        metadata: {
          'name': widget.mountain.name,
        },
        onEvent: (status) {
          _onDowloadEvent(status);
        },
      );

      setState(() {
        region = downloadedRegion;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _saveOfflineDestination(region) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('OFFLINE_DESTINATION_${region.id}',
        jsonEncode(widget.destination.toJson()));

    // image
    final image = API().baseURL + widget.mountain.mountainImages[0].url;

    var response = await http.get(Uri.parse(image));
    Directory? externalStorageDirectory = await getExternalStorageDirectory();
    File file =
        File(path.join(externalStorageDirectory!.path, path.basename(image)));
    await file.writeAsBytes(response.bodyBytes);

    preferences.setString('OFFLINE_DESTINATION_IMAGE_${region.id}', file.path);
  }

  Future<void> _showDialog(String message, String type, double progress,
      Function() onPressed) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (type == 'unique') {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                defaultRadius,
              ),
            ),
            icon: Image.asset(
              'assets/images/check_icon.png',
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
                  message,
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
        } else if (type == 'loading') {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                defaultRadius,
              ),
            ),
            icon: null,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 15,
                ),
                CircularProgressIndicator(
                  backgroundColor: redColor,
                  color: primaryColor,
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Mengunduh Peta Offline ${(progress * 100).round()}%',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        } else if (type == 'success') {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                defaultRadius,
              ),
            ),
            icon: Image.asset(
              'assets/images/check_icon.png',
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
                  message,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
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
        } else {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                defaultRadius,
              ),
            ),
            icon: Image.asset(
              'assets/images/failed_icon.png',
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
                  message,
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
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultSpace,
          right: defaultSpace,
          top: 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: redAccentColor,
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: whiteColor,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Offline map',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: black,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 7.5,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget action() {
      return Visibility(
        visible: !isDownloading,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            height: 110,
            child: Container(
              margin: EdgeInsets.only(
                left: defaultSpace,
                right: defaultSpace,
                bottom: defaultSpace,
                top: 20,
              ),
              height: 70,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                ),
                onPressed: _downloadRegion,
                child: Text(
                  'Download Map',
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    color: whiteColor,
                    fontWeight: bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget illustration() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
          left: defaultSpace,
          right: defaultSpace,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/download_illustration.png',
          ),
        ),
      );
    }

    Widget progress() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 20,
          left: defaultSpace,
          right: defaultSpace,
        ),
        child: Visibility(
          visible: isDownloading,
          child: Column(
            children: [
              Text(
                'Mengunduh Peta Offline ${(downloadProgress * 100).round()}%',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                backgroundColor: Colors.grey.shade500,
                color: primaryColor,
                minHeight: 20,
                value: ((downloadProgress * 100).round()) / 100,
                borderRadius: BorderRadius.all(Radius.circular(defaultRadius)),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  header(),
                  illustration(),
                  progress(),
                ],
              ),
            ),
            action(),
          ],
        ),
      ),
    );
  }
}
