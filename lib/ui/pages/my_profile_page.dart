import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/ui/pages/sign_in_page.dart';
import 'package:hike_navigator/ui/pages/static/privacy_and_policy.dart';
import 'package:hike_navigator/ui/pages/static/terms_and_condition.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget {
  final SharedPreferences? preferences;

  const MyProfilePage({Key? key, required this.preferences}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool isOnline = false;

  Future checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isOnline = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isOnline = false;
      });
    }
  }

  @override
  void initState() {
    checkConnection();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void logout() {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ),
          (Route route) => false);
    }

    Future<void> _showDialog(
        String text, String status, Function() onPressed) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                defaultRadius,
              ),
            ),
            icon: Image.asset(
              status == 'success'
                  ? 'assets/images/check_icon.png'
                  : 'assets/images/failed_icon.png',
              width: 45,
              height: 45,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  text.toString(),
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    void clearUserData() async {
      Navigator.pop(context);
      if (isOnline == true) {
        final userId = widget.preferences?.getInt('user_id');
        final result = await API().postRequestWithToken(
            route: '/climbing-plans/$userId/clear', payload: {});

        widget.preferences!.clear();
        final response = jsonDecode(result.body);

        if (response['status'] == 400) {
          _showDialog(
            response['message'],
            'success',
            () => {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const SignInPage(),
                ),
                (route) => false,
              ),
            },
          );
        } else {
          _showDialog(
            response['message'],
            'failed',
            () => {
              Navigator.pop(context),
            },
          );
        }
      } else {
        _showDialog(
          'No internet connection',
          'failed',
          () => {
            Navigator.pop(context),
          },
        );
      }
    }

    void privacyAndPolicy() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PrivacyAndPolicy()),
      );
    }

    void termsAndCondition() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const TermsAndCondition()));
    }

    void clear() {
      Widget cancelButton() {
        return TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: TextButton.styleFrom(
            backgroundColor: greyColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          ),
          child: Text(
            'Cancel',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              color: whiteColor,
            ),
          ),
        );
      }

      Widget confirmButton() {
        return TextButton(
          onPressed: () {
            clearUserData();
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
          ),
          child: Text(
            'Yes, Clear data',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              color: whiteColor,
            ),
          ),
        );
      }

      Column content() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              'Warning!',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: bold,
                color: blackColor,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'All your data will be deleted, continue?',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: medium,
                color: greyColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cancelButton(),
                const SizedBox(
                  width: 15,
                ),
                confirmButton(),
              ],
            ),
          ],
        );
      }

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                defaultRadius,
              ),
            ),
            content: content(),
          );
        },
      );
    }

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
                  'assets/images/default.jpg',
                ),
                radius: 67.5,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.preferences!.getString('name').toString(),
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.preferences!.getString('role').toString(),
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: medium,
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
            onTap: () {
              privacyAndPolicy();
            },
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
            onTap: () {
              termsAndCondition();
            },
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
                  color: greyColor,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              clear();
            },
            child: Column(
              children: [
                ListTile(
                  tileColor: whiteColor,
                  title: Text(
                    'Clear data',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  leading: Icon(
                    Icons.clear_all,
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
          const SizedBox(
            height: 20,
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
