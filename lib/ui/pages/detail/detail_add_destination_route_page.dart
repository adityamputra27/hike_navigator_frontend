import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/pages/detail/detail_add_destination_download_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/select_peak_item.dart';
import 'package:hike_navigator/ui/widgets/select_route_item.dart';

class DetailAddDestinationRoutePage extends StatefulWidget {
  const DetailAddDestinationRoutePage({super.key});

  @override
  State<DetailAddDestinationRoutePage> createState() =>
      _DetailAddDestinationRoutePageState();
}

class _DetailAddDestinationRoutePageState
    extends State<DetailAddDestinationRoutePage> {
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
                'Create Plan',
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
          color: whiteColor,
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
                      'Jalur Cibodas',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                content: SizedBox.shrink(),
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
                      'Puncak Pangrango',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: semiBold,
                      ),
                    ),
                  ],
                ),
                content: SizedBox.shrink(),
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
            SizedBox(
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
            SelectPeakItem(),
            SelectPeakItem(),
            SizedBox(
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
            SelectRouteItem(),
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
