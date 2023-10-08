import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/cubit/destinations_cubit.dart';
import 'package:hike_navigator/models/province_model.dart';
import 'package:hike_navigator/services/configuration_service.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/chip_filter_item.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final SharedPreferences? preferences;
  const HomePage({Key? key, required this.preferences}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<OfflineRegion>? offlineMaps;

  String searchQuery = '';
  int searchProvince = 0;

  ValueNotifier<int> activeProvinceFilterIndexNotifier = ValueNotifier<int>(-1);
  List<ProvinceModel> provinces = [];

  void fetchProvinces() async {
    try {
      List<ProvinceModel> fetchedProvinces =
          await ConfigurationService().fetchProvinces();
      setState(() {
        provinces = fetchedProvinces;
      });
    } catch (e) {
      print('Error fetching provinces: $e');
    }
  }

  void setActiveProvinceFilterIndex(int index, String id) {
    setState(() {
      activeProvinceFilterIndexNotifier.value = index;
      searchProvince = int.parse(id);
    });
  }

  @override
  void initState() {
    context
        .read<DestinationsCubit>()
        .fetchDestinations(searchQuery, searchProvince);
    fetchProvinces();
    _getOfflineMap();
    super.initState();
  }

  void startSearch() {
    context
        .read<DestinationsCubit>()
        .fetchDestinations(searchQuery, searchProvince);
  }

  void startFilter() {
    context
        .read<DestinationsCubit>()
        .fetchDestinations(searchQuery, searchProvince);
    Navigator.pop(context);
  }

  void resetFilter() {
    setState(() {
      searchProvince = 0;
      activeProvinceFilterIndexNotifier.value = -1;
    });
    context
        .read<DestinationsCubit>()
        .fetchDestinations(searchQuery, searchProvince);
    Navigator.pop(context);
  }

  _getOfflineMap() async {
    final regions = await getListOfRegions();
    setState(() {
      offlineMaps = regions;
    });
  }

  @override
  Widget build(BuildContext context) {
    void showModalFilterProvince() {
      showModalBottomSheet(
        isScrollControlled: true,
        elevation: 2,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (_) {
          return ValueListenableBuilder<int>(
            valueListenable: activeProvinceFilterIndexNotifier,
            builder: (context, value, child) {
              return Stack(
                alignment: AlignmentDirectional.topCenter,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 10,
                    child: Container(
                      width: 40,
                      height: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: redAccentColor,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 40,
                          left: defaultSpace,
                          right: defaultSpace,
                        ),
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: provinces.asMap().entries.map((entry) {
                            int index = entry.key;
                            return ChipFilterItem(
                              id: entry.value.id,
                              name: entry.value.name,
                              isActive: index == value,
                              widgetIndex: index,
                              setActiveIndex: setActiveProvinceFilterIndex,
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 55,
                        margin: EdgeInsets.only(
                          top: 20,
                          left: defaultSpace,
                          right: defaultSpace,
                          bottom: defaultSpace,
                        ),
                        child: TextButton(
                          onPressed: startFilter,
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Apply',
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
                          left: defaultSpace,
                          right: defaultSpace,
                          bottom: defaultSpace,
                        ),
                        child: TextButton(
                          onPressed: resetFilter,
                          style: TextButton.styleFrom(
                            backgroundColor: greyColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            'Reset',
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
                ],
              );
            },
          );
        },
      );
    }

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
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  onSubmitted: (value) {
                    startSearch();
                  },
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
            InkWell(
              onTap: () {
                showModalFilterProvince();
              },
              child: Container(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
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
      return offlineMaps != null
          ? Container(
              // margin: EdgeInsets.only(
              //   top: 40,
              //   left: defaultSpace,
              //   right: defaultSpace,
              // ),
              // child: Column(
              //   children: offlineMaps!.map((offlineMap) {
              //     return DestinationCard(
              //       offlineMap: offlineMap,
              //     );
              //   }).toList(),
              // ),
              )
          : Center(
              child: Container(
                margin: const EdgeInsets.only(
                  top: 50,
                ),
                child: const CircularProgressIndicator(),
              ),
            );

      // return BlocConsumer<DestinationsCubit, DestinationsState>(
      //   builder: (context, state) {
      //     if (state is DestinationsSuccess) {
      //       if (state.destinations.isNotEmpty) {
      //         return Container(
      //           margin: EdgeInsets.only(
      //             top: 40,
      //             left: defaultSpace,
      //             right: defaultSpace,
      //           ),
      //           child: Column(
      //             children: [],
      //           ),
      //         );
      //       } else {
      //         return Container(
      //           margin: EdgeInsets.only(
      //             top: 50,
      //             left: defaultSpace,
      //             right: defaultSpace,
      //           ),
      //           child: Text(
      //             "Oopps... you don't have any destination!",
      //             style: GoogleFonts.inter(
      //               fontSize: 14,
      //               fontWeight: semiBold,
      //             ),
      //             textAlign: TextAlign.center,
      //           ),
      //         );
      //       }
      //     }
      //     return Center(
      //       child: Container(
      //         margin: const EdgeInsets.only(
      //           top: 50,
      //         ),
      //         child: const CircularProgressIndicator(),
      //       ),
      //     );
      //   },
      //   listener: (context, state) {
      //     if (state is DestinationsFailed) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           backgroundColor: Colors.redAccent,
      //           content: Text(state.error),
      //         ),
      //       );
      //     }
      //   },
      // );
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
