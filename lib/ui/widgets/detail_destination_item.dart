import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class DetailDestinationItem extends StatelessWidget {
  final String image;
  final String name;
  final int total;

  const DetailDestinationItem({
    Key? key,
    required this.image,
    required this.name,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                image,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Text(
          name,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: greyColor,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          total.toString(),
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: bold,
            color: blackColor,
          ),
        ),
      ],
    );
  }
}
