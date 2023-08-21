import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/ui/pages/sign_in_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/text_form_field_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController(text: '');

  final TextEditingController emailController = TextEditingController(text: '');

  final TextEditingController passwordController =
      TextEditingController(text: '');

  final TextEditingController confirmationPasswordController =
      TextEditingController(text: '');

  void register() async {
    final payload = {
      'email': emailController.text.toString(),
      'password': passwordController.text.toString(),
      'name': nameController.text.toString(),
    };
    final result =
        await API().postRequest(route: '/register', payload: payload);
    final response = jsonDecode(result.body);

    if (response['status'] == 200) {
      _showDialog(
        response['message'],
        'success',
        () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
          );
        },
      );
    }
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
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
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

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          left: defaultSpace,
          right: defaultSpace,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Text(
              'Welcome!',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: blackColor,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Create new account',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: greyColor,
              ),
            ),
          ],
        ),
      );
    }

    Widget form() {
      return Column(
        children: [
          TextFormFieldAuth(
            icon: Icon(
              Icons.person_outline,
              color: blackColor,
              size: 25,
            ),
            hintText: 'Full name',
            controller: nameController,
            margin: EdgeInsets.only(
              top: 20,
              left: defaultSpace,
              right: defaultSpace,
            ),
          ),
          TextFormFieldAuth(
            icon: Icon(
              Icons.email_outlined,
              color: blackColor,
              size: 25,
            ),
            hintText: 'Email',
            controller: emailController,
            margin: EdgeInsets.only(
              left: defaultSpace,
              right: defaultSpace,
            ),
          ),
          TextFormFieldAuth(
            icon: Icon(
              Icons.lock,
              color: blackColor,
              size: 25,
            ),
            hintText: 'Password',
            controller: passwordController,
            obsecureText: true,
            margin: EdgeInsets.only(
              left: defaultSpace,
              right: defaultSpace,
            ),
          ),
          TextFormFieldAuth(
            icon: Icon(
              Icons.lock,
              color: blackColor,
              size: 25,
            ),
            hintText: 'Repeat Password',
            controller: confirmationPasswordController,
            obsecureText: true,
            margin: EdgeInsets.only(
              left: defaultSpace,
              right: defaultSpace,
            ),
          ),
        ],
      );
    }

    Widget button() {
      return Column(
        children: [
          Container(
            width: double.infinity,
            height: 55,
            margin: EdgeInsets.only(
              top: 30,
              left: defaultSpace,
              right: defaultSpace,
            ),
            child: TextButton(
              onPressed: () {
                register();
              },
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shadowColor: Colors.grey.shade400,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Create account',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: 20,
                bottom: 20,
                left: defaultSpace,
                right: defaultSpace,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account? '),
                  Text(
                    'Sign In',
                    style: GoogleFonts.inter(
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            form(),
            button(),
          ],
        ),
      ),
    );
  }
}
