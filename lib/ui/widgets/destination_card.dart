import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:hike_navigator/ui/pages/detail/detail_add_destination_map_page.dart';
import 'package:hike_navigator/ui/pages/main_page.dart';
import 'package:hike_navigator/ui/pages/start_destination_map_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:intl/intl.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DestinationCard extends StatefulWidget {
  final DestinationsModel destination;
  final OfflineRegion offlineMap;

  const DestinationCard({
    required this.destination,
    required this.offlineMap,
    super.key,
  });

  @override
  State<DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<DestinationCard> {
  File? offlineSaveImage;

  bool isOnline = false;
  Future checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
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

  @override
  void initState() {
    loadOfflineSaveImage();
    checkConnection();

    super.initState();
  }

  void loadOfflineSaveImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final path = preferences
        .getString('OFFLINE_DESTINATION_IMAGE_${widget.offlineMap.id}');
    if (path != null) {
      setState(() {
        offlineSaveImage = File(path);
      });
    }
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

  @override
  Widget build(BuildContext context) {
    void cancelDestination() async {
      Navigator.pop(context);
      if (isOnline == true) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        final result = await API().postRequestWithToken(
          route: '/climbing-plans/${widget.destination.id}/cancel',
          payload: {},
        );

        final response = jsonDecode(result.body);
        if (response['status'] == 400) {
          preferences.remove('OFFLINE_DESTINATION_${widget.offlineMap.id}');
          preferences
              .remove('OFFLINE_DESTINATION_IMAGE_${widget.offlineMap.id}');

          _showDialog(
            response['message'],
            'success',
            () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainPage(preferences: preferences),
                ),
              )
            },
          );
        } else {
          _showDialog(
            response['message'],
            'failed',
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(preferences: preferences),
              ),
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

    void showBottomModal() {
      showModalBottomSheet(
        elevation: 2,
        isScrollControlled: true,
        context: context,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 30,
            left: defaultSpace,
            right: defaultSpace,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/date.png',
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    '${widget.destination.mountain.name} - ${widget.destination.mountain.province.name}',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: bold,
                      color: blackColor,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateFormat('dd MMMM yyyy').format(
                        DateTime.parse(widget.destination.scheduleDate)),
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: medium,
                      color: greyColor,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Prepare yourself, it’s only 2 days left before your new adventure is started',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: normal,
                      color: greyColor,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 55,
                margin: const EdgeInsets.only(
                  top: 35,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StartDestinationMapPage(
                          destination: widget.destination,
                          offlineMap: widget.offlineMap,
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Start Journey',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 55,
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: TextButton(
                  onPressed: cancelDestination,
                  style: TextButton.styleFrom(
                    backgroundColor: greyColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Cancel it',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailAddDestinationMapPage(
              mountain: widget.destination.mountain,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          image: offlineSaveImage != null
              ? DecorationImage(
                  image: FileImage(offlineSaveImage!),
                  fit: BoxFit.cover,
                )
              : null,
          borderRadius: BorderRadius.circular(
            25,
          ),
        ),
        child: Container(
          margin:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.destination.mountain.name,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      color: blackColor,
                      fontWeight: bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.destination.mountain.height,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: blackColor,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.location_on,
                            color: whiteColor,
                            size: 18,
                          ),
                        ),
                        TextSpan(
                          text: widget.destination.mountain.province.name
                              .toString(),
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: whiteColor,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shadowColor: Colors.grey.shade400,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      showBottomModal();
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.visibility,
                              color: whiteColor,
                              size: 16,
                            ),
                          ),
                          TextSpan(
                            text: ' Preview',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: whiteColor,
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
