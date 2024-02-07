import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/models/posts_model.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class SelectRouteItem extends StatefulWidget {
  final String name;
  final String time;
  final int widgetIndex;
  final bool isActive;
  final Function(int) setActiveIndex;
  final List<PostsModel> posts;

  const SelectRouteItem({
    required this.name,
    required this.time,
    required this.widgetIndex,
    required this.isActive,
    required this.setActiveIndex,
    required this.posts,
    super.key,
  });

  @override
  State<SelectRouteItem> createState() => _SelectRouteItemState();
}

class _SelectRouteItemState extends State<SelectRouteItem> {
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
                      color: widget.isActive ? whiteColor : blackColor,
                      fontWeight: semiBold,
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    '${widget.time} hours hiking time',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: greyColor,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (widget.isActive)
                    Row(
                      children: [
                        Text(
                          widget.posts.isNotEmpty
                              ? 'Camps available'
                              : 'Camps not available',
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
