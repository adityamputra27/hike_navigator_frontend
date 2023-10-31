import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/constans/helper.dart';
import 'package:hike_navigator/cubit/page_cubit.dart';
import 'package:hike_navigator/methods/api.dart';
import 'package:hike_navigator/models/province_model.dart';
import 'package:hike_navigator/services/configuration_service.dart';
import 'package:hike_navigator/ui/pages/add_destination_page.dart';
import 'package:hike_navigator/ui/pages/home_page.dart';
import 'package:hike_navigator/ui/pages/my_destination_page.dart';
import 'package:hike_navigator/ui/pages/my_profile_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/navigation_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  final SharedPreferences? preferences;

  const MainPage({Key? key, required this.preferences}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isOnline = false;

  String newVersion = '';
  String currVersion = '';
  @override
  void initState() {
    versionCheck();
    fetchProvinces();
    checkConnection();

    super.initState();
  }

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

  versionCheck() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    final url = "${API().getURL()}/configuration/getSettings";
    final token = await API().getToken();
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    final result = jsonDecode(response.body);
    final version = result['data']['version'];

    if (isVersionGreaterThan(version, currentVersion)) {
      showDialogUpdateNotification();
    }

    setState(() {
      currVersion = currentVersion;
      newVersion = version;
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  void fetchProvinces() async {
    if (!mounted) return;
    try {
      List<ProvinceModel> fetchedProvinces =
          await ConfigurationService().fetchProvinces();

      widget.preferences!
          .setString('OFFLINE_PROVINCE', jsonEncode(fetchedProvinces));
    } catch (e) {
      if (mounted) {
        print('Error fetching provinces: $e');
      }
    }
  }

  Future<void> showDialogUpdateNotification() async {
    return showDialog<void>(
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                'Update Available!',
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
                'You can now update this app from $currVersion to $newVersion',
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
                  TextButton(
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
                      'Maybe Later',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  TextButton(
                    onPressed: () {
                      _launchURL(
                          'https://play.google.com/store/apps/details?id=&hl=id&gl=US');
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
                      'Update Now',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content(int index) {
      switch (index) {
        case 0:
          return HomePage(
            preferences: widget.preferences,
          );
        case 1:
          return MyDestinationPage(
            preferences: widget.preferences,
          );
        case 2:
          return MyProfilePage(
            preferences: widget.preferences,
          );
        default:
          return HomePage(
            preferences: widget.preferences,
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

    Widget navigation(int currentIndex) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(
                20,
              ),
              topRight: Radius.circular(
                20,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavigationItem(
                imageUrl: 'assets/images/home.png',
                index: 0,
                currentIndex: currentIndex,
              ),
              NavigationItem(
                imageUrl: 'assets/images/destination.png',
                index: 1,
                currentIndex: currentIndex,
              ),
              NavigationItem(
                imageUrl: 'assets/images/profile.png',
                index: 2,
                currentIndex: currentIndex,
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
            children: [
              content(state),
              navigation(state),
            ],
          ),
          floatingActionButton: state == 0
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: SizedBox(
                    width: 65,
                    height: 65,
                    child: FittedBox(
                      child: FloatingActionButton(
                        onPressed: () {
                          if (isOnline == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const AddDestinationPage(),
                              ),
                            );
                          } else {
                            _showDialog(
                              'No internet connection',
                              'failed',
                              () => {
                                Navigator.pop(context),
                              },
                            );
                          }
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              17.5,
                            ),
                          ),
                        ),
                        backgroundColor: primaryColor,
                        child: const Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }
}
