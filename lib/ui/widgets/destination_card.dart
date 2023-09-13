import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class DestinationCard extends StatelessWidget {
  final MountainsModel mountain;
  const DestinationCard(this.mountain, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage(
            'https://asset.kompas.com/crops/Vod4oaUnv0UCNEPqpmUbnMufLcA=/0x0:1800x1200/750x500/data/photo/2021/03/30/6062c10e95b4d.jpg',
          ),
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
          ],
        ),
      ),
    );
  }
}
