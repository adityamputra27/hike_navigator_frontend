import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

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
                  'Terms and Conditions',
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
                  'Welcome to Hike Navigator!',
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
                  "These terms and conditions outline the rules and regulations for the use of Hike Navigator's App",
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
                  'By installing this app we assume you accept these terms and conditions. Do not continue to use Hike Navigator if you do not agree to take all of the terms and conditions stated on this page.',
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
                  'The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: "Client", "You" and "Your" refers to you, the person log on this website and compliant to the Company’s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same. Our Terms and Conditions were created with the help of the Terms & Conditions Generator.',
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
                  "We employ the use of cookies. By accessing Hike Navigator, you agreed to use cookies in agreement with the Hike Navigator's Privacy Policy.",
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
                  "Most interactive websites use cookies to let us retrieve the user's details for each visit. Cookies are used by our website to enable the functionality of certain areas to make it easier for people visiting our website. Some of our affiliate/advertising partners may also use cookies.",
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
                  'License',
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
                  'You must not:',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1. Republish material from Hike Navigator',
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
                        '2. Sell, rent or sub-license material from Hike Navigator',
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
                        '3. Reproduce, duplicate or copy material from Hike Navigator',
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
                        '4. Redistribute content from Hike Navigator',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: blackColor,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'This Agreement shall begin on the date hereof.',
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
                  'Parts of this website offer an opportunity for users to post and exchange opinions and information in certain areas of the website. Hike Navigator does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of Hike Navigator,its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Hike Navigator shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website.',
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
                  'Hike Navigator reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.',
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
                  'You warrant and represent that:',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: blackColor,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1. You are entitled to post the Comments on our website and have all necessary licenses and consents to do so;',
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
                        '2. The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;',
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
                        '3. The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy',
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
                        '4. The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: blackColor,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'You hereby grant Hike Navigator a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.',
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
