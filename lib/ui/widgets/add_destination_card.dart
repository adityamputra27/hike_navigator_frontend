import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:hike_navigator/ui/pages/detail/detail_add_destination_map_page.dart';
import 'package:hike_navigator/ui/pages/detail/detail_add_destination_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class AddDestinationCard extends StatelessWidget {
  final MountainsModel mountain;
  const AddDestinationCard({required this.mountain, super.key});

  @override
  Widget build(BuildContext context) {
    String imageURL = mountain.mountainImages.isNotEmpty
        ? API().baseURL + mountain.mountainImages[0].url
        : 'https://www.foodnavigator.com/var/wrbm_gb_food_pharma/storage/images/3/0/7/5/235703-6-eng-GB/CEM-CORP-SIC-Food-20142.jpg';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailAddDestinationPage(
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
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
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
                          text: mountain.province.name,
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const DetailAddDestinationMapPage(),
                        ),
                      );
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
