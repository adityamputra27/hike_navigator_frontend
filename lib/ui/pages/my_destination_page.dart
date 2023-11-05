import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/cubit/destinations_cubit.dart';
import 'package:hike_navigator/cubit/destinations_saved_cubit.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:hike_navigator/models/destinations_saved_model.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/my_destination_card.dart';
import 'package:hike_navigator/ui/widgets/my_saved_destination_card.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDestinationPage extends StatefulWidget {
  final SharedPreferences? preferences;

  const MyDestinationPage({Key? key, required this.preferences})
      : super(key: key);

  @override
  State<MyDestinationPage> createState() => _MyDestinationPageState();
}

class _MyDestinationPageState extends State<MyDestinationPage> {
  bool isOnline = false;
  List<OfflineRegion>? offlineMaps;

  @override
  void initState() {
    context.read<DestinationsCubit>().fetchDestinations('', 0);
    context.read<DestinationsSavedCubit>().fetchDestinationsSaved();

    _getOfflineMap();
    checkConnection();
    super.initState();
  }

  _getOfflineMap() async {
    List<OfflineRegion> regions = await getListOfRegions();
    setState(() {
      offlineMaps = regions;
    });
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
      List<Widget> offlineDetinations = [];
      if (offlineMaps != null && widget.preferences != null) {
        offlineDetinations = offlineMaps!
            .map<Widget>((offlineMap) {
              var prefDestination = widget.preferences!
                  .getString('OFFLINE_DESTINATION_${offlineMap.id}');

              if (prefDestination != null) {
                final offlineDestination =
                    DestinationsModel.fromJsonWithPreferences(
                        jsonDecode(prefDestination));

                return Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: MyDestinationCard(
                    destination: offlineDestination,
                    offlineMap: offlineMap,
                  ),
                );
              }
              return const SizedBox();
            })
            .where((destinationCard) => destinationCard != const SizedBox())
            .toList();
      } else {
        return Center(
          child: Container(
            margin: const EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: const CircularProgressIndicator(),
          ),
        );
      }

      return Container(
        margin: EdgeInsets.only(
          left: defaultSpace,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: offlineDetinations),
        ),
      );
    }

    Widget bookmarkDestination() {
      return BlocConsumer<DestinationsSavedCubit, DestinationsSavedState>(
        builder: (context, state) {
          if (state is DestinationsSavedSuccess) {
            return Container(
              margin: const EdgeInsets.only(
                bottom: 125,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: state.destinationsSaved.map(
                    (DestinationsSavedModel destination) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: MySavedDestinationCard(
                          destination: destination,
                        ),
                      );
                    },
                  ).toList(),
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
          if (state is DestinationsSavedFailed) {
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
            bookmarkDestination(),
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
            if (isOnline == true) bookmark(),
          ],
        ),
      ),
    );
  }
}
