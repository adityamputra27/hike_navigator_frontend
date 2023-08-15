import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class SelectRouteItem extends StatefulWidget {
  const SelectRouteItem({super.key});

  @override
  State<SelectRouteItem> createState() => _SelectRouteItemState();
}

class _SelectRouteItemState extends State<SelectRouteItem> {
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
          color: primaryColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jalur Cibodas',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: whiteColor,
                    fontWeight: semiBold,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  '8-9 hours hiking time',
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: greyColor,
                    fontWeight: medium,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'Camps available',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: medium,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      'assets/images/camp.png',
                      width: 30,
                      height: 30,
                    ),
                  ],
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
