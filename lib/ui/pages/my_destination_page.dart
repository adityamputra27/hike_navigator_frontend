import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/cubit/destinations_cubit.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:hike_navigator/models/mountain_model.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/my_destination_card.dart';
import 'package:hike_navigator/ui/widgets/my_saved_destination_card.dart';

class MyDestinationPage extends StatefulWidget {
  const MyDestinationPage({super.key});

  @override
  State<MyDestinationPage> createState() => _MyDestinationPageState();
}

class _MyDestinationPageState extends State<MyDestinationPage> {
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
              'My Destination',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: black,
              ),
            ),
            const SizedBox(
              height: 7.5,
            ),
            Text(
              'Where would you like to go?',
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

    Widget destination() {
      return BlocConsumer<DestinationsCubit, DestinationsState>(
        builder: (context, state) {
          if (state is DestinationsSuccess) {
            return Container(
              margin: EdgeInsets.only(
                left: defaultSpace,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      state.destinations.map((DestinationsModel destination) {
                    return Column(
                      children: [
                        MyDestinationCard(
                          destination: destination,
                          mountain: destination.mountain,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }
          return Center(
            child: Container(
              margin: const EdgeInsets.only(
                top: 20,
                bottom: 20,
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

    Widget bookmark() {
      return Container(
        margin: EdgeInsets.only(
          top: 30,
          left: defaultSpace,
          right: defaultSpace,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Text(
              'Saved Destination',
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: black,
              ),
            ),
            const SizedBox(
              height: 7.5,
            ),
            Text(
              'List of your saved destinations',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: greyColor,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 125,
              ),
              child: const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MySavedDestinationCard(),
                    SizedBox(
                      width: 30,
                    ),
                    MySavedDestinationCard(),
                    SizedBox(
                      width: 30,
                    ),
                    MySavedDestinationCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            destination(),
            bookmark(),
          ],
        ),
      ),
    );
  }
}
