import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hike_navigator/ui/pages/main_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        const Duration(
          seconds: 3,
        ), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(
            preferences: widget.preferences,
          ),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
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
      ),
    );
  }
}
