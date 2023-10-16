import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/destinations_saved_model.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class MySavedDestinationCard extends StatelessWidget {
  final DestinationsSavedModel destination;
  const MySavedDestinationCard({required this.destination, super.key});

  @override
  Widget build(BuildContext context) {
    String imageURL = destination.mountain.mountainImages.isNotEmpty
        ? API().baseURL + destination.mountain.mountainImages[0].url
        : 'https://www.foodnavigator.com/var/wrbm_gb_food_pharma/storage/images/3/0/7/5/235703-6-eng-GB/CEM-CORP-SIC-Food-20142.jpg';

    return Container(
      width: 300,
      height: 450,
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
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.mountain.name,
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
                  destination.mountain.height,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
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
                    text: destination.mountain.province.name,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: whiteColor,
                      fontWeight: bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
