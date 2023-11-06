import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hike_navigator/constans/ad_helper.dart';

import '../../constans/destination.dart';

/// A simple app that loads a native ad.
class NativeExample extends StatefulWidget {
  final List<Destination> destination;

  const NativeExample({
    required this.destination,
    Key? key,
  }) : super(key: key);

  @override
  NativeExampleState createState() => NativeExampleState();
}

class NativeExampleState extends State<NativeExample> {
  NativeAd? _nativeAd;
  static const _kNativeAdIndex = 4;

  // final double _adAspectRatioSmall = (91 / 355);
  // final double _adAspectRatioMedium = (370 / 355);

  @override
  void initState() {
    super.initState();

    NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _nativeAd = ad as NativeAd;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          debugPrint(
              'Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  Widget getAd() {
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
    return SizedBox(
      height: 50,
      child: AdWidget(ad: bannerAd),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AdMob Native Inline Ad'),
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox();
          },
          itemCount: widget.destination.length,
          itemBuilder: (context, index) {
            if (index % 2 == 0) {
              return getAd();
            }
            final item = widget.destination[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.duration),
              onTap: () {
                debugPrint('Clicked ${item.name}');
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  // COMPLETE: Add _getDestinationItemIndex()
  int _getDestinationItemIndex(int rawIndex) {
    if (rawIndex >= _kNativeAdIndex && _nativeAd != null) {
      return rawIndex - 1;
    }
    return rawIndex;
  }
}
