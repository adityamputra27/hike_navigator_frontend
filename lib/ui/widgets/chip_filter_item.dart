import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/extensions/string_extension.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class ChipFilterItem extends StatefulWidget {
  final String id;
  final String name;
  final int widgetIndex;
  final bool isActive;
  final Function(int, String) setActiveIndex;

  const ChipFilterItem({
    required this.id,
    required this.name,
    required this.widgetIndex,
    required this.isActive,
    required this.setActiveIndex,
    super.key,
  });

  @override
  State<ChipFilterItem> createState() => _ChipFilterItemState();
}

class _ChipFilterItemState extends State<ChipFilterItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (!widget.isActive) {
            widget.setActiveIndex(widget.widgetIndex, widget.id);
          }
        });
      },
      child: Chip(
        backgroundColor: widget.isActive ? primaryColor : transparentColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: widget.isActive ? transparentColor : blackColor,
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
                color: widget.isActive ? whiteColor : blackColor),
          ),
        ),
      ),
    );
  }
}
