import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/cubit/mountains_cubit.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/add_destination_card.dart';

class AddDestinationPage extends StatefulWidget {
  const AddDestinationPage({super.key});

  @override
  State<AddDestinationPage> createState() => _AddDestinationPageState();
}

class _AddDestinationPageState extends State<AddDestinationPage> {
  @override
  void initState() {
    context.read<MountainsCubit>().fetchMountains();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultSpace,
          right: defaultSpace,
          bottom: 40,
          top: 20,
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
                      'Add Destination',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: black,
                        color: blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 7.5,
                    ),
                    Text(
                      'Choose your new destination',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: greyColor,
                      ),
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
      return BlocConsumer<MountainsCubit, MountainsState>(
        builder: (context, state) {
          if (state is MountainsSuccess) {
            return Container(
              margin: EdgeInsets.only(
                top: 40,
                left: defaultSpace,
                right: defaultSpace,
              ),
              child: Column(
                children: state.mountains.map((MountainsModel mountain) {
                  return Column(
                    children: [
                      AddDestinationCard(
                        mountain: mountain,
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
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
          if (state is MountainsFailed) {
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
          ],
        ),
      ),
    );
  }
}
