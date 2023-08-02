import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/destination_card.dart';
import 'package:hike_navigator/ui/widgets/my_destination_card.dart';

class MyDestinationPage extends StatelessWidget {
  const MyDestinationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultSpace,
          right: defaultSpace,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              'My Destination',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: black,
              ),
            ),
            const SizedBox(
              height: 7.5,
            ),
            Text(
              'Where would you like to go?',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: greyColor,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    }

    Widget destination() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultSpace,
        ),
        child: const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              MyDestinationCard(),
              SizedBox(
                width: 30,
              ),
              MyDestinationCard(),
              SizedBox(
                width: 30,
              ),
              MyDestinationCard(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            top: 20,
          ),
          child: ListView(
            children: [
              header(),
              destination(),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 65,
        height: 65,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  17.5,
                ),
              ),
            ),
            backgroundColor: primaryColor,
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
