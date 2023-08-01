import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/pages/sign_in_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/text_form_field_auth.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

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
            controller: emailController,
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
            controller: emailController,
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
            controller: emailController,
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
              onPressed: () {},
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
