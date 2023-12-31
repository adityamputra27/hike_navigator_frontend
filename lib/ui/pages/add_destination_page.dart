import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hike_navigator/constans/ad_helper.dart';
import 'package:hike_navigator/cubit/mountains_cubit.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:hike_navigator/models/province_model.dart';
import 'package:hike_navigator/services/configuration_service.dart';
import 'package:hike_navigator/ui/shared/theme.dart';
import 'package:hike_navigator/ui/widgets/add_destination_card.dart';
import 'package:hike_navigator/ui/widgets/chip_filter_item.dart';

class AddDestinationPage extends StatefulWidget {
  const AddDestinationPage({super.key});

  @override
  State<AddDestinationPage> createState() => _AddDestinationPageState();
}

class _AddDestinationPageState extends State<AddDestinationPage> {
  String searchQuery = '';
  int searchProvince = 0;

  ValueNotifier<int> activeProvinceFilterIndexNotifier = ValueNotifier<int>(-1);
  List<ProvinceModel> provinces = [];

  NativeAd? _bannerAd;
  static const _kBannerAdIndex = 5;

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
    context.read<MountainsCubit>().fetchMountains(searchQuery, searchProvince);
    fetchProvinces();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kBannerAdIndex && _bannerAd != null) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  void startSearch() {
    context.read<MountainsCubit>().fetchMountains(searchQuery, searchProvince);
  }

  void startFilter() {
    context.read<MountainsCubit>().fetchMountains(searchQuery, searchProvince);
    Navigator.pop(context);
  }

  void resetFilter() {
    setState(() {
      searchProvince = 0;
      activeProvinceFilterIndexNotifier.value = -1;
    });
    context.read<MountainsCubit>().fetchMountains(searchQuery, searchProvince);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    void showModalFilterProvince() {
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: whiteColor,
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

    Widget ads() {
      BannerAdListener bannerAdListener =
          BannerAdListener(onAdWillDismissScreen: (ad) {
        ad.dispose();
      }, onAdClosed: (ad) {
        debugPrint('Ad Got Closed');
      });
      BannerAd bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: bannerAdListener,
        request: const AdRequest(),
      );

      bannerAd.load();

      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        height: 50,
        child: AdWidget(ad: bannerAd),
      );
    }

    Widget destination() {
      return BlocConsumer<MountainsCubit, MountainsState>(
        builder: (context, state) {
          if (state is MountainsSuccess) {
            List<Widget> destinationWidgets = [];
            if (state.mountains.isNotEmpty) {
              for (var i = 0; i < state.mountains.length; i++) {
                if (i > 0 && i % _kBannerAdIndex == 0) {
                  destinationWidgets.add(ads());
                }
                MountainsModel mountain =
                    state.mountains[_getDestinationItemIndex(i)];
                destinationWidgets.add(
                  Column(
                    children: [
                      AddDestinationCard(mountain: mountain),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                );
              }
            } else {
              return Container(
                margin: EdgeInsets.only(
                  top: 50,
                  left: defaultSpace,
                  right: defaultSpace,
                ),
                child: Text(
                  "Oopps... search destination not found!",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return Container(
              margin: EdgeInsets.only(
                top: 40,
                left: defaultSpace,
                right: defaultSpace,
              ),
              child: Column(children: destinationWidgets),
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
