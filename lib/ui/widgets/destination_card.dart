import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:hike_navigator/ui/pages/detail/detail_add_destination_download_page.dart';
import 'package:hike_navigator/ui/pages/detail/detail_add_destination_map_page.dart';
import 'package:hike_navigator/ui/pages/start_destination_map_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:intl/intl.dart';

class DestinationCard extends StatelessWidget {
  final MountainsModel mountain;
  final DestinationsModel destination;

  const DestinationCard(
      {required this.mountain, required this.destination, super.key});

  @override
  Widget build(BuildContext context) {
    String imageURL = mountain.mountainImages.isNotEmpty
        ? API().baseURL + mountain.mountainImages[0].url
        : 'https://www.foodnavigator.com/var/wrbm_gb_food_pharma/storage/images/3/0/7/5/235703-6-eng-GB/CEM-CORP-SIC-Food-20142.jpg';

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
                    '${destination.mountain.name} - ${destination.mountain.province.name}',
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
                    DateFormat('dd MMMM yyyy')
                        .format(DateTime.parse(destination.scheduleDate)),
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
                          builder: (context) =>
                              const DetailAddDestinationDownloadPage()),
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
            builder: (context) => StartDestinationMapPage(
              mountain: mountain,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageURL),
            fit: BoxFit.cover,
          ),
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
                    mountain.name,
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
                    mountain.height,
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
                          text: mountain.province.name.toString(),
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
