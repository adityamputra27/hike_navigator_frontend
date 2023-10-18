import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/cubit/page_cubit.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/ui/pages/forgot_password_page.dart';
import 'package:hike_navigator/ui/pages/main_page.dart';
import 'package:hike_navigator/ui/pages/sign_up_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/text_form_field_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController(text: '');

  final TextEditingController passwordController =
      TextEditingController(text: '');

  bool emailValidate = false;
  bool passwordValidate = false;

  void login() async {
    context.read<PageCubit>().setPage(0);

    final payload = {
      'email': emailController.text.toString(),
      'password': passwordController.text.toString(),
    };
    final result = await API().postRequest(
      route: '/login',
      payload: payload,
    );
    final response = jsonDecode(result.body);

    if (response['status'] == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setInt('user_id', response['user']['id']);
      await preferences.setString('name', response['user']['name']);
      await preferences.setString('email', response['user']['email']);
      await preferences.setString('role', response['user']['role']);
      await preferences.setString('token', response['token']);
      await preferences.setString('version', response['setting']['version']);

      _showDialog(
        response['message'],
        'success',
        () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => MainPage(
                preferences: preferences,
              ),
            ),
            (Route route) => false,
          );
        },
      );
    } else {
      _showDialog(response['message'], 'error', () => Navigator.pop(context));
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
                  fontSize: 18,
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
            errorText: emailValidate ? 'Email is required' : null,
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
            errorText: passwordValidate ? 'Password is required' : null,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgotPassword()),
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
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  emailController.text.isEmpty
                      ? emailValidate = true
                      : emailValidate = false;
                });

                setState(() {
                  passwordController.text.isEmpty
                      ? passwordValidate = true
                      : passwordValidate = false;
                });

                if (!emailValidate && !passwordValidate) {
                  login();
                }
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
                MaterialPageRoute(builder: (context) => const SignUpPage()),
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
