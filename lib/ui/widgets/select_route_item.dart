import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class SelectRouteItem extends StatefulWidget {
  final String name;
  const SelectRouteItem({required this.name, super.key});

  @override
  State<SelectRouteItem> createState() => _SelectRouteItemState();
}

class _SelectRouteItemState extends State<SelectRouteItem> {
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
            bottom: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: active ? whiteColor : blackColor,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
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
                  const SizedBox(
                    height: 5,
                  ),
                  if (active)
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
                        const SizedBox(
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
