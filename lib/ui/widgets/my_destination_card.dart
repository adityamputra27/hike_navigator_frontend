import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/ui/shared/theme.dart';

class MyDestinationCard extends StatelessWidget {
  const MyDestinationCard({super.key});

  @override
  Widget build(BuildContext context) {
    void showBottomModal() {
      showModalBottomSheet(
        elevation: 2,
        isScrollControlled: true,
        context: context,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 30,
            left: defaultSpace,
            right: defaultSpace,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 140,
                height: 140,
                padding: EdgeInsets.only(
                  top: 20,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/date.png',
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    'Gunung Gede - Puncak Pangrango',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: bold,
                      color: blackColor,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '05 Agustus 2023',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: medium,
                      color: greyColor,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Prepare yourself, it’s only 2 days left before your new adventure is started',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: normal,
                      color: greyColor,
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: 55,
                margin: EdgeInsets.only(
                  top: 35,
                ),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Start Journey',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 55,
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: greyColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Cancel it',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      width: 300,
      height: 450,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage(
            'https://asset.kompas.com/crops/Vod4oaUnv0UCNEPqpmUbnMufLcA=/0x0:1800x1200/750x500/data/photo/2021/03/30/6062c10e95b4d.jpg',
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(
          25,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gunung Semeru',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    color: blackColor,
                    fontWeight: bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '3676 mdpl',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: medium,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    shadowColor: Colors.grey.shade400,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    showBottomModal();
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.visibility,
                            color: whiteColor,
                            size: 16,
                          ),
                        ),
                        TextSpan(
                          text: ' Preview',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: whiteColor,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.date_range_outlined,
                          color: whiteColor,
                          size: 18,
                        ),
                      ),
                      TextSpan(
                        text: ' Tomorrow',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: whiteColor,
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
