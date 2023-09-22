import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/extensions/string_extension.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class ChipFilterItem extends StatefulWidget {
  final String name;
  const ChipFilterItem({required this.name, super.key});

  @override
  State<ChipFilterItem> createState() => _ChipFilterItemState();
}

class _ChipFilterItemState extends State<ChipFilterItem> {
  bool isClicked = false;

  void onChipTapped() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChipTapped,
      child: Chip(
        backgroundColor: isClicked ? primaryColor : transparentColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: isClicked ? transparentColor : blackColor,
            width: 1.5,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        label: Container(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
            top: 3,
            bottom: 3,
          ),
          child: Text(
            widget.name.toLowerCase().capitalize(),
            style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: medium,
                letterSpacing: 0.5,
                color: isClicked ? whiteColor : blackColor),
          ),
        ),
      ),
    );
  }
}
