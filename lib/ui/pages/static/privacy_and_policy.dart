import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Policy for Hike Navigator',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    color: blackColor,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'At Hike Navigator, accessible from hike-navigator.com, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Hike Navigator and how we use it.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Location Permissions',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Hike Navigator requires access to your GPS location for optimal functionality. This information is solely used to provide you with accurate navigation services and is not shared with third parties. You can choose to disable location services through your device settings, but please note that this may affect the app's performance.",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Cookies',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Like any other website, Hike Navigator uses cookies. These cookies are used to store information including visitors' preferences, and the pages on the website that the visitor accessed or visited. The information is used to optimize the users' experience by customizing our web page content based on visitors' browser type and/or other information.",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Google DoubleClick DART Cookie',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Google is one of a third-party vendor on our site. It also uses cookies, known as DART cookies, to serve ads to our site visitors based upon their visit to www.website.com and other sites on the internet. However, visitors may choose to decline the use of DART cookies by visiting the Google ad and content network Privacy Policy at the following URL – https://policies.google.com/technologies/ads',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Privacy Policies',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Third-party ad servers or ad networks uses technologies like cookies, JavaScript, or Web Beacons that are used in their respective advertisements and links that appear on Hike Navigator, which are sent directly to users' browser. They automatically receive your IP address when this occurs. These technologies are used to measure the effectiveness of their advertising campaigns and/or to personalize the advertising content that you see on websites that you visit.",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Note that Hike Navigator has no access to or control over these cookies that are used by third-party advertisers.",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Children's Information",
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Another part of our priority is adding protection for children while using the internet. We encourage parents and guardians to observe, participate in, and/or monitor and guide their online activity.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Hike Navigator does not knowingly collect any Personal Identifiable Information from children under the age of 13. If you think that your child provided this kind of information on our website, we strongly encourage you to contact us immediately and we will do our best efforts to promptly remove such information from our records.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
