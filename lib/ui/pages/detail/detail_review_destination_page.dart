import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/models/mountain_model.dart';
import 'package:hike_navigator/ui/pages/detail/detail_add_destination_download_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:intl/intl.dart';

class DetailReviewDestinationPage extends StatefulWidget {
  final DateTime scheduleDate;
  final MountainModel mountain;

  final String peakId;
  final String trackId;
  final String peakName;
  final String trackName;

  const DetailReviewDestinationPage({
    Key? key,
    required this.mountain,
    required this.scheduleDate,
    required this.peakId,
    required this.peakName,
    required this.trackId,
    required this.trackName,
  }) : super(key: key);

  @override
  State<DetailReviewDestinationPage> createState() =>
      _DetailReviewDestinationPageState();
}

class _DetailReviewDestinationPageState
    extends State<DetailReviewDestinationPage> {
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
                      'Review',
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
                        const DetailAddDestinationDownloadPage(),
                  ),
                );
              },
              child: Text(
                'Create My Plan',
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
                      widget.trackName,
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
                      widget.peakName,
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

    Widget destination() {
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
              height: 10,
            ),
            Text(
              'Destination',
              style: GoogleFonts.inter(
                fontSize: 22,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.mountain.name,
              style: GoogleFonts.inter(
                fontSize: 22,
                color: blackColor,
                fontWeight: medium,
              ),
            ),
          ],
        ),
      );
    }

    Widget detail() {
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
              'Date',
              style: GoogleFonts.inter(
                fontSize: 22,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              DateFormat('EEEEE, dd MMMM y').format(widget.scheduleDate),
              style: GoogleFonts.inter(
                fontSize: 20,
                color: blackColor,
                fontWeight: medium,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Offline Map',
              style: GoogleFonts.inter(
                fontSize: 22,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.mountain.isMapOffline,
              style: GoogleFonts.inter(
                fontSize: 20,
                color: blackColor,
                fontWeight: medium,
              ),
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
                  destination(),
                  stepper(),
                  detail(),
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
