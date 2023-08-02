import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key});

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
                  'Gunung Semeru',
                  style: GoogleFonts.inter(
                    fontSize: 26,
                    color: blackColor,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '3676 mdpl',
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
                      size: 20,
                    ),
                  ),
                  TextSpan(
                    text: 'Jawa Timur',
                    style: GoogleFonts.inter(
                      fontSize: 18,
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
