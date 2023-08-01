import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class TextFormFieldAuth extends StatelessWidget {
  final Icon icon;
  final String hintText;
  final bool obsecureText;
  final EdgeInsets margin;
  final TextEditingController controller;

  const TextFormFieldAuth({
    Key? key,
    required this.icon,
    required this.hintText,
    this.obsecureText = false,
    this.margin = EdgeInsets.zero,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            cursorColor: Colors.black,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: normal,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  defaultRadius,
                ),
                borderSide: BorderSide(
                  color: greyColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  defaultRadius,
                ),
                borderSide: BorderSide(
                  color: greyColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  defaultRadius,
                ),
                borderSide: BorderSide(
                  color: greyColor,
                ),
              ),
              filled: true,
              fillColor: whiteColor,
              prefixIcon: Container(
                padding: EdgeInsets.only(
                  left: defaultSpace,
                  right: 16,
                ),
                child: icon,
              ),
            ),
            obscureText: obsecureText,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
