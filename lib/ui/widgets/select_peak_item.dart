import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class SelectPeakItem extends StatefulWidget {
  const SelectPeakItem({Key? key}) : super(key: key);

  @override
  State<SelectPeakItem> createState() => _SelectPeakItemState();
}

class _SelectPeakItemState extends State<SelectPeakItem> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: active ? primaryColor : lightGreyColor,
          elevation: 5,
          shadowColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defaultRadius,
            ),
          ),
        ),
        onPressed: () {
          setState(() {
            active = !active;
          });
        },
        child: Container(
          padding: const EdgeInsets.only(
            top: 15,
            left: 5,
            right: 5,
            bottom: 20,
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
                      color: active ? whiteColor : blackColor,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
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
              if (active)
                Image.asset(
                  'assets/images/check_icon.png',
                  width: 30,
                  height: 30,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
