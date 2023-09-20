import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/models/mountain_peaks_model.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:hike_navigator/models/tracks_model.dart';
import 'package:hike_navigator/ui/pages/detail/detail_review_destination_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/select_peak_item.dart';
import 'package:hike_navigator/ui/widgets/select_route_item.dart';

class DetailAddDestinationRoutePage extends StatefulWidget {
  final MountainsModel mountain;
  final List<MountainPeaksModel> mountainPeaks;
  final DateTime scheduleDate;
  const DetailAddDestinationRoutePage({
    Key? key,
    required this.mountain,
    required this.mountainPeaks,
    required this.scheduleDate,
  }) : super(key: key);

  @override
  State<DetailAddDestinationRoutePage> createState() =>
      _DetailAddDestinationRoutePageState();
}

class _DetailAddDestinationRoutePageState
    extends State<DetailAddDestinationRoutePage> {
  int activePeakIndex = -1;
  int activeTrackIndex = -1;

  List<TracksModel> trackLists = [];

  String? peakId;
  String? trackId;
  String peakNameSelected = '-';
  String pointNameSelected = '-';

  void setActivePeakIndex(int index) {
    setState(() {
      activePeakIndex = index;
      trackLists = widget.mountainPeaks[index].tracks;
      peakNameSelected = widget.mountainPeaks[index].peak.name;
      peakId = widget.mountainPeaks[index].peak.id;
    });
  }

  void setActiveTrackIndex(int index) {
    setState(() {
      activeTrackIndex = index;
      pointNameSelected = trackLists[index].title;
      trackId = trackLists[index].id;
    });
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
                      'Select Route',
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
      return Align(
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
              onPressed: () {
                if (peakId == null || trackId == null) {
                  _showDialog(
                    'Please select peak and route!',
                    'failed',
                    () => {
                      Navigator.pop(context),
                    },
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailReviewDestinationPage(
                        scheduleDate: widget.scheduleDate,
                        mountain: widget.mountain,
                        peakId: peakId.toString(),
                        peakName: peakNameSelected,
                        trackId: trackId.toString(),
                        trackName: pointNameSelected,
                      ),
                    ),
                  );
                }
              },
              child: Text(
                'Select Route',
                style: GoogleFonts.inter(
                  fontSize: 26,
                  color: whiteColor,
                  fontWeight: bold,
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget stepper() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: defaultSpace,
          left: defaultSpace,
          right: defaultSpace,
        ),
        decoration: BoxDecoration(
          color: lightGreyColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 5,
            top: 5,
          ),
          child: Stepper(
            steps: [
              Step(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Starting point',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: greyColor,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      pointNameSelected,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                content: const SizedBox.shrink(),
              ),
              Step(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Peak goal',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: greyColor,
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      peakNameSelected,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                content: const SizedBox.shrink(),
              ),
            ],
            controlsBuilder: (context, details) {
              return Container();
            },
          ),
        ),
      );
    }

    Widget selectPeaks() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultSpace,
          right: defaultSpace,
          bottom: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              'Which peak do you want?',
              style: GoogleFonts.inter(
                fontSize: 22,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
            if (widget.mountainPeaks.isNotEmpty)
              Column(
                children: widget.mountainPeaks.asMap().entries.map((entry) {
                  int index = entry.key;
                  return SelectPeakItem(
                    name: entry.value.peak.name,
                    height: entry.value.peak.height,
                    widgetIndex: index,
                    isActive: index == activePeakIndex,
                    setActiveIndex: setActivePeakIndex,
                  );
                }).toList(),
              ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Which route do you want?',
              style: GoogleFonts.inter(
                fontSize: 22,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
            if (activePeakIndex >= 0)
              if (trackLists.isNotEmpty)
                Column(
                  children: trackLists.asMap().entries.map((entry) {
                    int index = entry.key;
                    return SelectRouteItem(
                      name: entry.value.title,
                      widgetIndex: index,
                      isActive: index == activeTrackIndex,
                      setActiveIndex: setActiveTrackIndex,
                      posts: entry.value.posts,
                    );
                  }).toList(),
                ),
          ],
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
                  stepper(),
                  selectPeaks(),
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
