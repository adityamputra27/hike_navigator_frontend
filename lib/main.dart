import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hike_navigator/ui/pages/my_destination_page.dart';
import 'package:hike_navigator/ui/pages/splash_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashPage(),
    );
  }
}
