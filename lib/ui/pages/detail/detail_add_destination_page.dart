import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/mountain_peaks_model.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:hike_navigator/ui/pages/detail/detail_add_destination_date_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hike_navigator/ui/widgets/detail_destination_item.dart';
import 'package:hike_navigator/ui/widgets/detail_mountain_item.dart';
import 'package:hike_navigator/ui/widgets/detail_track_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailAddDestinationPage extends StatefulWidget {
  final MountainsModel mountain;
  const DetailAddDestinationPage({required this.mountain, super.key});

  @override
  State<DetailAddDestinationPage> createState() =>
      _DetailAddDestinationPageState();
}

class _DetailAddDestinationPageState extends State<DetailAddDestinationPage> {
  final List urlImages = [];
  int activeIndex = 0;
  int waterfallTotal = 0;
  int riverTotal = 0;
  int campTotal = 0;
  int waterspringTotal = 0;

  @override
  void initState() {
    for (var image in widget.mountain.mountainImages) {
      urlImages.add(API().baseURL + image.url);
    }
    for (var mountainPeak in widget.mountain.mountainPeaks) {
      for (var track in mountainPeak.tracks) {
        if (track.waterfalls.isNotEmpty) {
          waterfallTotal += track.waterfalls.length;
        }
        if (track.rivers.isNotEmpty) {
          riverTotal += track.rivers.length;
        }
        if (track.posts.isNotEmpty) {
          campTotal += track.posts.length;
        }
        if (track.watersprings.isNotEmpty) {
          waterspringTotal += track.watersprings.length;
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<MountainPeaksModel> mountainPeaks =
        widget.mountain.mountainPeaks;

    Widget buildCarousel(String url, int index) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget buildCarouselIndicator() {
      return AnimatedSmoothIndicator(
        effect: ExpandingDotsEffect(
          dotWidth: 15,
          dotHeight: 10,
          dotColor: redGreyColor,
          activeDotColor: redColor,
        ),
        activeIndex: activeIndex,
        count: urlImages.length,
      );
    }

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
                      widget.mountain.name,
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: black,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 7.5,
                    ),
                    Text(
                      '${widget.mountain.city.name}, ${widget.mountain.province.name}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: greyColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                  height: 50,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 40, bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider.builder(
                    itemCount: urlImages.length,
                    itemBuilder: (context, index, realIndex) {
                      final image = urlImages[index];
                      return buildCarousel(image, index);
                    },
                    options: CarouselOptions(
                      onPageChanged: (index, reason) {
                        setState(() {
                          activeIndex = index;
                        });
                      },
                      autoPlay: true,
                      height: 375,
                      viewportFraction: 1,
                      autoPlayInterval: const Duration(
                        seconds: 3,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buildCarouselIndicator(),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.mountain.name,
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
                  widget.mountain.height,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: greyColor,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Description',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: bold,
                    color: blackColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.mountain.description,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: greyColor,
                    height: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DetailDestinationItem(
                      image: 'assets/images/water_fall_round.png',
                      name: 'Water Fall',
                      total: waterfallTotal,
                    ),
                    DetailDestinationItem(
                      image: 'assets/images/river_round.png',
                      name: 'River',
                      total: riverTotal,
                    ),
                    DetailDestinationItem(
                      image: 'assets/images/camp_round.png',
                      name: 'Camp',
                      total: campTotal,
                    ),
                    DetailDestinationItem(
                      image: 'assets/images/water_springs_round.png',
                      name: 'Water Springs',
                      total: waterfallTotal,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Top of the mountain',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: bold,
                    color: blackColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (mountainPeaks.isNotEmpty)
                  Column(
                    children: mountainPeaks.map((mountainPeak) {
                      return DetailMountainItem(
                        name:
                            '${mountainPeak.peak.name} ${mountainPeak.peak.height}',
                      );
                    }).toList(),
                  ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Track of the mountain',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: bold,
                    color: blackColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (mountainPeaks.isNotEmpty)
                  Column(
                    children: mountainPeaks.map((mountainPeak) {
                      List<Widget> trackWidgets = [];
                      if (mountainPeak.tracks.length > 0 &&
                          mountainPeak.tracks.isNotEmpty) {
                        trackWidgets = mountainPeak.tracks.map((track) {
                          return DetailTrackItem(
                            name: track.title,
                          );
                        }).toList();
                      }
                      return Column(
                        children: trackWidgets,
                      );
                    }).toList(),
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
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(
                    left: defaultSpace,
                    right: 10,
                    bottom: 10,
                    top: 10,
                  ),
                  height: 70,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius),
                      ),
                    ),
                    onPressed: () {},
                    child: Icon(
                      Icons.bookmark,
                      color: whiteColor,
                      size: 35,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  margin: EdgeInsets.only(
                    right: defaultSpace,
                    bottom: 10,
                    top: 10,
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
                          builder: (context) => DetailAddDestinationDatePage(
                            mountainPeaks: widget.mountain.mountainPeaks,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Add journey',
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        color: whiteColor,
                        fontWeight: bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  header(),
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
