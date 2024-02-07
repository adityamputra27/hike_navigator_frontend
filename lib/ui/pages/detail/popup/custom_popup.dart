import 'package:flutter/material.dart';

class CustomPopup extends StatefulWidget {
  const CustomPopup({super.key});

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(width: 100, height: 100, color: Colors.white,);
  }
}
