import 'package:flutter/material.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class NavigationItem extends StatelessWidget {
  final String imageUrl;
  final int currentIndex;
  final int index;

  const NavigationItem({
    Key? key,
    required this.imageUrl,
    required this.currentIndex,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 75,
        height: 55,
        padding: const EdgeInsets.all(11.5),
        decoration: BoxDecoration(
          color: currentIndex == index ? primaryColor : transparentColor,
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
        child: Image.asset(
          imageUrl,
          color: currentIndex == index ? whiteColor : greyColor,
        ),
      ),
    );
  }
}
