import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/destination_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              'Hello, Aditya!',
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

    Widget filter() {
      return Container(
        margin: EdgeInsets.only(
          right: defaultSpace,
          left: defaultSpace,
        ),
        child: Row(
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(
                  right: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: greyColor.withOpacity(
                        0.25,
                      ),
                      offset: const Offset(0, 7.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: normal,
                    color: greyColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'search destination',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xffF1F1F2),
                    prefixIcon: Container(
                      padding: EdgeInsets.only(
                        left: defaultSpace,
                        right: 16,
                      ),
                      child: Icon(
                        Icons.search,
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/filter.png',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget destination() {
      return Container(
        margin: EdgeInsets.only(
          top: 40,
          left: defaultSpace,
          right: defaultSpace,
        ),
        child: const Column(
          children: [
            DestinationCard(),
            SizedBox(
              height: 35,
            ),
            DestinationCard(),
            SizedBox(
              height: 35,
            ),
            DestinationCard(),
            SizedBox(
              height: 35,
            ),
          ],
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
              filter(),
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
