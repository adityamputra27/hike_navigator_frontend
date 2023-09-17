import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/models/mountain_peaks_model.dart';
import 'package:hike_navigator/models/tracks_model.dart';
import 'package:hike_navigator/ui/pages/detail/detail_add_destination_download_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/select_peak_item.dart';
import 'package:hike_navigator/ui/widgets/select_route_item.dart';

class DetailAddDestinationRoutePage extends StatefulWidget {
  final List<MountainPeaksModel> mountainPeaks;
  final String scheduleDate;
  const DetailAddDestinationRoutePage({
    Key? key,
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

  String peakNameSelected = '-';
  String pointNameSelected = '-';

  void setActivePeakIndex(int index) {
    setState(() {
      activePeakIndex = index;
      trackLists = widget.mountainPeaks[index].tracks;
      peakNameSelected = widget.mountainPeaks[index].peak.name;
    });
  }

  void setActiveTrackIndex(int index) {
    setState(() {
      activeTrackIndex = index;
      pointNameSelected = trackLists[index].title;
    });
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const DetailAddDestinationDownloadPage()));
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
