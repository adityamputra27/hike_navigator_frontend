import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget image() {
      return Container(
        margin: const EdgeInsets.only(
          top: 60,
        ),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            const CircleAvatar(
              radius: 75,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/ten_hag.jpg',
                ),
                radius: 65,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Aditya Muhamad Putra P., S.T',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    Widget action() {
      return ListView(
        children: [
          InkWell(
            onTap: () {},
            child: Column(
              children: [
                ListTile(
                  tileColor: whiteColor,
                  title: Text(
                    'Privacy and Policy',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  leading: Icon(
                    Icons.lock,
                    color: blackColor,
                  ),
                ),
                Container(
                  height: 0.5,
                  color: blackColor,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Column(
              children: [
                ListTile(
                  tileColor: whiteColor,
                  title: Text(
                    'Terms and Condition',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  leading: Icon(
                    Icons.info_rounded,
                    color: blackColor,
                  ),
                ),
                Container(
                  height: 0.5,
                  color: blackColor,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Column(
              children: [
                ListTile(
                  tileColor: whiteColor,
                  title: Text(
                    'Sign Out',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  leading: Icon(
                    Icons.logout,
                    color: blackColor,
                  ),
                ),
                Container(
                  height: 0.5,
                  color: blackColor,
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          image(),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: action()),
        ],
      ),
    );
  }
}
