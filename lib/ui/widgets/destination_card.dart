import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:hike_navigator/services/location_service.dart';
import 'package:hike_navigator/ui/pages/detail/detail_add_destination_map_page.dart';
import 'package:hike_navigator/ui/pages/main_page.dart';
import 'package:hike_navigator/ui/pages/start_destination_map_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:intl/intl.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
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
  LocationService locationService = LocationService();
  File? offlineSaveImage;
  bool isOnline = false;
  int _seconds = 3;
  Timer? _timer;

  @override
  void initState() {
    _seconds = 3;
    loadOfflineSaveImage();
    checkConnection();
    locationService.requestPermission();

    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
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

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => StartDestinationMapPage(
                destination: widget.destination,
                offlineMap: widget.offlineMap,
              ),
            ),
          );
        }
      });
    });
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

  Future<void> _showTimerDialog() {
    startTimer();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defaultRadius,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 15,
              ),
              CircularProgressIndicator(
                backgroundColor: primaryColor,
                color: redColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Starting your journey...',
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
            ],
          ),
        );
      },
    );
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
    final scheduleDate = DateTime.parse(widget.destination.scheduleDate);
    final currentDate = DateTime.now();
    Duration diff = scheduleDate.difference(currentDate);

    void startDestination() async {
      Navigator.pop(context);
      if (diff.inDays.toInt() == 0) {
        _showTimerDialog();
      } else if (diff.isNegative) {
        _showDialog(
          'Your journey has been missed! ',
          'failed',
          () => Navigator.pop(context),
        );
      } else {
        _showDialog(
          "You can't start your journey today!",
          'failed',
          () => Navigator.pop(context),
        );
      }
    }

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
          preferences.remove('CHECK_POINTS_${widget.offlineMap.id}');

          _showDialog(
            'Successfully cancel your schedule!',
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
        backgroundColor: whiteColor,
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
                    DateFormat('dd MMMM yyyy').format(scheduleDate),
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
                    diff.isNegative || diff.inDays.toString() == "0"
                        ? 'Prepare yourself, today is your new adventure is started'
                        : 'Prepare yourself, it’s only ${diff.inDays.toInt() + 1} days left before your new adventure is started',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: medium,
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
                  onPressed: startDestination,
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
              Container(
                width: double.infinity,
                height: 55,
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: transparentColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: greyColor,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Close',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: greyColor,
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
