import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/pages/sign_in_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget {
  final SharedPreferences? preferences;

  const MyProfilePage({Key? key, required this.preferences}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  void logout() {
    widget.preferences!.clear();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SignInPage()));
  }

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
              widget.preferences!.getString('name').toString(),
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
                  color: greyColor,
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
            onTap: () {
              logout();
            },
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
