import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/cubit/destinations_cubit.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/destination_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final SharedPreferences? preferences;
  const HomePage({Key? key, required this.preferences}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<DestinationsCubit>().fetchDestinations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultSpace,
          right: defaultSpace,
          top: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              'Hello, ${widget.preferences?.getString('name').toString()}!',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: black,
              ),
            ),
            const SizedBox(
              height: 7.5,
            ),
            Text(
              'List of your destination',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: greyColor,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    }

    Widget filter() {
      return Container(
        margin: EdgeInsets.only(
          right: defaultSpace,
          left: defaultSpace,
        ),
        child: Row(
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.only(
                  right: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: greyColor.withOpacity(
                        0.25,
                      ),
                      offset: const Offset(0, 5),
                      blurRadius: 2.5,
                    )
                  ],
                ),
                child: TextField(
                  cursorColor: Colors.black,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: normal,
                    color: greyColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'search destination',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    filled: true,
                    fillColor: const Color(0xffF1F1F2),
                    prefixIcon: Container(
                      padding: EdgeInsets.only(
                        left: defaultSpace,
                        right: 16,
                      ),
                      child: Icon(
                        Icons.search,
                        color: blackColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/filter.png',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget destination() {
      return BlocConsumer<DestinationsCubit, DestinationsState>(
        builder: (context, state) {
          if (state is DestinationsSuccess) {
            if (state.destinations.isNotEmpty) {
              return Container(
                margin: EdgeInsets.only(
                  top: 40,
                  left: defaultSpace,
                  right: defaultSpace,
                ),
                child: Column(
                  children:
                      state.destinations.map((DestinationsModel destination) {
                    return Column(
                      children: [
                        DestinationCard(destination.mountain),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.only(
                  top: 50,
                  left: defaultSpace,
                  right: defaultSpace,
                ),
                child: Text(
                  "Oopps... you don't have any destination!",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
          }
          return Center(
            child: Container(
              margin: const EdgeInsets.only(
                top: 50,
              ),
              child: const CircularProgressIndicator(),
            ),
          );
        },
        listener: (context, state) {
          if (state is DestinationsFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.redAccent,
                content: Text(state.error),
              ),
            );
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            filter(),
            destination(),
            const SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
}
