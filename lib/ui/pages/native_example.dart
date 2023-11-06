import 'dart:io';

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
  final double _adAspectRatioMedium = (370 / 355);

  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AdMob Native Inline Ad'),
        ),
        body: ListView.builder(
          // COMPLETE: Adjust itemCount based on the ad load state
          itemCount: widget.destination.length + (_nativeAd != null ? 1 : 0),
          itemBuilder: (context, index) {
            // COMPLETE: Render a native ad
            if (_ad != null && index == _kNativeAdIndex) {
              return Container(
                height: 72.0,
                alignment: Alignment.center,
                child: AdWidget(ad: _nativeAd!),
              );
            } else {
              // COMPLETE: Get adjusted item index from _getDestinationItemIndex()
              final item = widget.destination[_getDestinationItemIndex(index)];

              return ListTile(

                title: Text(item.name),
                subtitle: Text(item.duration),
                onTap: () {
                  debugPrint('Clicked ${item.name}');
                },
              );
            }
          },
        ),
      );
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
