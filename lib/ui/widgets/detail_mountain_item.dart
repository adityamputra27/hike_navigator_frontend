import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class DetailMountainItem extends StatelessWidget {
  final String name;
  const DetailMountainItem({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/mountain_round.png',
            width: 40,
            height: 40,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            name,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: normal,
              color: greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
