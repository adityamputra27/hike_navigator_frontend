import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hike_navigator/models/destinations_model.dart';
import 'package:hike_navigator/models/province_model.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/chip_filter_item.dart';
import 'package:hike_navigator/ui/widgets/destination_card.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final SharedPreferences? preferences;
  const HomePage({Key? key, required this.preferences}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<OfflineRegion>? offlineMaps;
  bool isDestinationLoading = false;

  String searchQuery = '';
  int searchProvince = 0;

  ValueNotifier<int> activeProvinceFilterIndexNotifier = ValueNotifier<int>(-1);

  void setActiveProvinceFilterIndex(int index, String id) {
    setState(() {
      activeProvinceFilterIndexNotifier.value = index;
      searchProvince = int.parse(id);
    });
  }

  @override
  void initState() {
    _getOfflineMap();
    super.initState();
  }

  void startSearch() {
    setState(() {
      isDestinationLoading = true;
    });

    setState(() {
      isDestinationLoading = false;
    });
  }

  void startFilter() {
    Navigator.pop(context);
    setState(() {});
  }

  void resetFilter() {
    setState(() {
      searchProvince = 0;
      activeProvinceFilterIndexNotifier.value = -1;
    });
    setState(() {});
    Navigator.pop(context);
  }

  _getOfflineMap() async {
    List<OfflineRegion> regions = await getListOfRegions();
    setState(() {
      offlineMaps = regions;
    });
  }

  @override
  Widget build(BuildContext context) {
    void showModalFilterProvince() {
      showModalBottomSheet(
        backgroundColor: whiteColor,
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
              String? provincesJSON =
                  widget.preferences!.getString('OFFLINE_PROVINCE');

              var provincesDecode = jsonDecode(provincesJSON!);
              List<ProvinceModel> provinces = List<ProvinceModel>.from(
                  provincesDecode
                      .map((province) => ProvinceModel.fromJson(province)));

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
      List<Widget> filteredDestinations = [];
      if (offlineMaps != null && widget.preferences != null) {
        filteredDestinations = offlineMaps!
            .map<Widget>((offlineMap) {
              var prefDestination = widget.preferences!
                  .getString('OFFLINE_DESTINATION_${offlineMap.id}');

              if (prefDestination != null) {
                final offlineDestination =
                    DestinationsModel.fromJsonWithPreferences(
                        jsonDecode(prefDestination));

                if (offlineDestination.mountain.name
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) &&
                        (int.parse(offlineDestination.mountain.province.id) ==
                            searchProvince) ||
                    searchProvince == 0) {
                  return DestinationCard(
                    destination: offlineDestination,
                    offlineMap: offlineMap,
                  );
                }
              }
              return const SizedBox();
            })
            .where((destinationCard) => destinationCard != const SizedBox())
            .toList();
      } else {
        return Center(
          child: Container(
            margin: const EdgeInsets.only(
              top: 50,
            ),
            child: const CircularProgressIndicator(),
          ),
        );
      }

      return Container(
        margin: EdgeInsets.only(
          top: 40,
          left: defaultSpace,
          right: defaultSpace,
        ),
        child: Column(children: filteredDestinations),
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
