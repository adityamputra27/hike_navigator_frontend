import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hike_navigator/ui/pages/main_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SecondSplashPage extends StatefulWidget {
  final SharedPreferences? preferences;

  const SecondSplashPage({Key? key, required this.preferences})
      : super(key: key);

  @override
  State<SecondSplashPage> createState() => _SecondSplashPageState();
}

class _SecondSplashPageState extends State<SecondSplashPage> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(
                preferences: widget.preferences,
              ),
            ),
          );
        }
      },
    );
    super.initState();
  }

  Future<InitializationStatus> _initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: FutureBuilder<void>(
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 275,
                  height: 275,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        future: _initGoogleMobileAds(),
      ),
    );
  }
}
