import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hike_navigator/ui/pages/sign_in_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class MainSplashPage extends StatefulWidget {
  const MainSplashPage({super.key});

  @override
  State<MainSplashPage> createState() => _MainSplashPageState();
}

class _MainSplashPageState extends State<MainSplashPage> {
  @override
  void initState() {
    Timer(
        const Duration(
          seconds: 3,
        ), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignInPage()),
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
