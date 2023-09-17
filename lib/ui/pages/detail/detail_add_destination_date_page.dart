import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/models/mountain_peaks_model.dart';
import 'package:hike_navigator/ui/pages/detail/detail_add_destination_route_page.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailAddDestinationDatePage extends StatefulWidget {
  final List<MountainPeaksModel> mountainPeaks;
  const DetailAddDestinationDatePage({required this.mountainPeaks, super.key});

  @override
  State<DetailAddDestinationDatePage> createState() =>
      _DetailAddDestinationDatePageState();
}

class _DetailAddDestinationDatePageState
    extends State<DetailAddDestinationDatePage> {
  DateTime selectedDate = DateTime.now();
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final DateTime firstDay = DateTime(now.year, now.month - 3, now.day);
    final DateTime lastDay = DateTime(now.year, now.month + 3, now.day);

    void onlyDaySelected(DateTime day, DateTime focusedDay) {
      setState(() {
        now = day;
        selectedDate = day;
      });
    }

    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultSpace,
          right: defaultSpace,
          top: 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: redAccentColor,
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: whiteColor,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Select Date',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: black,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 7.5,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget action() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: double.infinity,
          height: 110,
          child: Container(
            margin: EdgeInsets.only(
              left: defaultSpace,
              right: defaultSpace,
              bottom: defaultSpace,
              top: 20,
            ),
            height: 70,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailAddDestinationRoutePage(
                      mountainPeaks: widget.mountainPeaks,
                      scheduleDate: selectedDate,
                    ),
                  ),
                );
              },
              child: Text(
                'Apply',
                style: GoogleFonts.inter(
                  fontSize: 26,
                  color: whiteColor,
                  fontWeight: bold,
                ),
              ),
            ),
          ),
        ),
      );
    }

    Widget date() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultSpace,
          right: defaultSpace,
          top: defaultSpace,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 15,
          ),
          child: TableCalendar(
            focusedDay: now,
            firstDay: firstDay,
            lastDay: lastDay,
            rowHeight: 80,
            availableGestures: AvailableGestures.all,
            onDaySelected: onlyDaySelected,
            selectedDayPredicate: (day) => isSameDay(day, now),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            daysOfWeekHeight: 60,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: GoogleFonts.inter(
                fontWeight: semiBold,
                color: greyColor,
              ),
              weekendStyle: GoogleFonts.inter(
                fontWeight: semiBold,
                color: greyColor,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              headerTitleBuilder: (context, date) {
                final DateFormat month = DateFormat.MMMM();
                final DateFormat year = DateFormat.y();
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    '${month.format(date)} ${year.format(date)}',
                    style: GoogleFonts.inter(
                      fontWeight: bold,
                      color: blackColor,
                      fontSize: 16,
                    ),
                  ),
                );
              },
              todayBuilder: (context, date, focusedDay) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: redGreyColor,
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: Text(
                    '${date.day}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: whiteColor,
                      fontWeight: bold,
                    ),
                  ),
                );
              },
              defaultBuilder: (context, date, _) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    '${date.day}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: greyColor,
                      fontWeight: medium,
                    ),
                  ),
                );
              },
              selectedBuilder: (context, date, _) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: redAccentColor,
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: Text(
                    '${date.day}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: whiteColor,
                      fontWeight: bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  header(),
                  date(),
                ],
              ),
            ),
            action(),
          ],
        ),
      ),
    );
  }
}
