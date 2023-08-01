import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/pages/forgot_password_page.dart';
import 'package:hike_navigator/ui/pages/sign_up_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/text_form_field_auth.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

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
              height: 10,
            ),
            const SizedBox(
              child: Image(
                image: AssetImage(
                  'assets/images/logo.png',
                ),
                width: 130,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Welcome back!',
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
              'Please enter your account here',
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
              Icons.email_outlined,
              color: blackColor,
              size: 25,
            ),
            hintText: 'Email',
            controller: emailController,
            margin: EdgeInsets.only(
              top: 20,
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotPassword()),
              );
            },
            child: Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(
                top: 20,
                left: 24,
                right: 24,
              ),
              child: Text(
                'Forgot Password?',
                style: GoogleFonts.inter(
                  color: primaryColor,
                ),
              ),
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
              top: 20,
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
                'Login',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 20,
              left: defaultSpace,
              right: defaultSpace,
            ),
            child: Text(
              'OR',
              style: GoogleFonts.inter(
                fontSize: 16,
                color: blackColor,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 55,
            margin: EdgeInsets.only(
              top: 20,
              left: defaultSpace,
              right: defaultSpace,
            ),
            child: ElevatedButton.icon(
              icon: const Image(
                width: 20,
                image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/2008px-Google_%22G%22_Logo.svg.png'),
              ),
              label: Text(
                'Google',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: redAccentColor,
                shadowColor: Colors.grey.shade400,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
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
                  const Text('Do not have any account? '),
                  Text(
                    'Sign Up',
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
