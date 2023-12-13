import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class SelectPeakItem extends StatefulWidget {
  final String name;
  final String height;
  final int widgetIndex;
  final bool isActive;
  final Function(int) setActiveIndex;

  const SelectPeakItem({
    Key? key,
    required this.name,
    required this.height,
    required this.widgetIndex,
    required this.isActive,
    required this.setActiveIndex,
  }) : super(key: key);

  @override
  State<SelectPeakItem> createState() => _SelectPeakItemState();
}

class _SelectPeakItemState extends State<SelectPeakItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: ElevatedButton(
        style: TextButton.styleFrom(
          backgroundColor: widget.isActive ? primaryColor : lightGreyColor,
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
            if (!widget.isActive) {
              widget.setActiveIndex(widget.widgetIndex);
            }
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
                    widget.name,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: widget.isActive ? whiteColor : blackColor,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    widget.height,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: greyColor,
                      fontWeight: medium,
                    ),
                  ),
                ],
              ),
              if (widget.isActive)
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
