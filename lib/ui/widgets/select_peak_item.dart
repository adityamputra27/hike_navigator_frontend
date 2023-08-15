import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class SelectPeakItem extends StatefulWidget {
  const SelectPeakItem({super.key});

  @override
  State<SelectPeakItem> createState() => _SelectPeakItemState();
}

class _SelectPeakItemState extends State<SelectPeakItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
        ),
        padding: EdgeInsets.only(
          top: 15,
          left: 35,
          right: 35,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Puncak Gede',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  '2958 mdpl',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: greyColor,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
            Image.asset(
              'assets/images/check_icon.png',
              width: 35,
              height: 35,
            ),
          ],
        ),
      ),
    );
  }
}
