import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/city_model.dart';
import 'package:hike_navigator/models/marks_model.dart';
import 'package:hike_navigator/models/mountain_images_model.dart';
import 'package:hike_navigator/models/mountain_peaks_model.dart';
import 'package:hike_navigator/models/posts_model.dart';
import 'package:hike_navigator/models/province_model.dart';
import 'package:hike_navigator/models/rivers_model.dart';
import 'package:hike_navigator/models/tracks_model.dart';
import 'package:hike_navigator/models/waterfalls_model.dart';
import 'package:hike_navigator/models/watersprings_model.dart';

class MountainsModel extends Equatable {
  final String id;
  final String name;
  final String latitude;
  final String longitude;
  final String isMapOffline;
  final CityModel city;
  final ProvinceModel province;
  final String height;
  final String status;
  final String description;
  final List<MountainImagesModel> mountainImages;
  final List<MountainPeaksModel> mountainPeaks;
  final List<TracksModel> mountainTracks;
  final List<MarksModel> mountainMarks;
  final List<WaterfallsModel> mountainWaterfalls;
  final List<WaterspringsModel> mountainWatersprings;
  final List<RiversModel> mountainRivers;
  final List<PostsModel> mountainPosts;

  const MountainsModel({
    required this.id,
    this.name = '',
    this.latitude = '',
    this.longitude = '',
    this.isMapOffline = '',
    required this.city,
    required this.province,
    this.height = '',
    this.status = '',
    this.description = '',
    required this.mountainImages,
    required this.mountainPeaks,
    required this.mountainTracks,
    required this.mountainMarks,
    required this.mountainWaterfalls,
    required this.mountainWatersprings,
    required this.mountainRivers,
    required this.mountainPosts,
  });

  factory MountainsModel.fromJson(Map<String, dynamic> json) {
    List<MountainImagesModel> mountainImages = [];
    List<MountainPeaksModel> mountainPeaks = [];
    List<TracksModel> mountainTracks = [];
    List<MarksModel> mountainMarks = [];
    List<WaterfallsModel> mountainWaterfalls = [];
    List<WaterspringsModel> mountainWatersprings = [];
    List<RiversModel> mountainRivers = [];
    List<PostsModel> mountainPosts = [];

    if (json['mountain_images'] != null) {
      mountainImages = (json['mountain_images'] as List)
          .map((image) => MountainImagesModel.fromJson(image))
          .toList();
    } else {
      mountainImages = [];
    }

    if (json['mountain_peaks'] != null) {
      mountainPeaks = (json['mountain_peaks'] as List)
          .map((peak) => MountainPeaksModel.fromJson(peak))
          .toList();
    } else {
      mountainPeaks = [];
    }

    if (json['mountain_tracks'] != null) {
      mountainTracks = (json['mountain_tracks'] as List)
          .map((track) => TracksModel.fromJson(track))
          .toList();
    } else {
      mountainTracks = [];
    }

    if (json['mountain_marks'] != null) {
      mountainMarks = (json['mountain_marks'] as List)
          .map((mark) => MarksModel.fromJson(mark))
          .toList();
    } else {
      mountainMarks = [];
    }

    if (json['mountain_waterfalls'] != null) {
      mountainWaterfalls = (json['mountain_waterfalls'] as List)
          .map((waterfall) => WaterfallsModel.fromJson(waterfall))
          .toList();
    } else {
      mountainWaterfalls = [];
    }

    if (json['mountain_watersprings'] != null) {
      mountainWatersprings = (json['mountain_watersprings'] as List)
          .map((waterspring) => WaterspringsModel.fromJson(waterspring))
          .toList();
    } else {
      mountainWatersprings = [];
    }

    if (json['mountain_rivers'] != null) {
      mountainRivers = (json['mountain_rivers'] as List)
          .map((river) => RiversModel.fromJson(river))
          .toList();
    } else {
      mountainRivers = [];
    }

    if (json['mountain_posts'] != null) {
      mountainPosts = (json['mountain_posts'] as List)
          .map((post) => PostsModel.fromJson(post))
          .toList();
    } else {
      mountainPosts = [];
    }

    return MountainsModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
      isMapOffline: json['is_map_offline'].toString(),
      city: CityModel.fromJson(json['city']),
      province: ProvinceModel.fromJson(json['province']),
      height: json['height'].toString(),
      status: json['status'].toString(),
      description: json['description'].toString(),
      mountainImages: mountainImages,
      mountainPeaks: mountainPeaks,
      mountainTracks: mountainTracks,
      mountainMarks: mountainMarks,
      mountainWaterfalls: mountainWaterfalls,
      mountainWatersprings: mountainWatersprings,
      mountainRivers: mountainRivers,
      mountainPosts: mountainPosts,
    );
  }

  factory MountainsModel.fromJsonWithPreferences(Map<String, dynamic> json) {
    List<MountainImagesModel> mountainImages = [];
    List<MountainPeaksModel> mountainPeaks = [];
    List<TracksModel> mountainTracks = [];
    List<MarksModel> mountainMarks = [];
    List<WaterfallsModel> mountainWaterfalls = [];
    List<WaterspringsModel> mountainWatersprings = [];
    List<RiversModel> mountainRivers = [];
    List<PostsModel> mountainPosts = [];

    if (json['mountainImages'] != null) {
      mountainImages = (json['mountainImages'] as List)
          .map((image) => MountainImagesModel.fromJson(image))
          .toList();
    } else {
      mountainImages = [];
    }

    if (json['mountainPeaks'] != null) {
      mountainPeaks = (json['mountainPeaks'] as List)
          .map((peak) => MountainPeaksModel.fromJson(peak))
          .toList();
    } else {
      mountainPeaks = [];
    }

    if (json['mountainTracks'] != null) {
      mountainTracks = (json['mountainTracks'] as List)
          .map((track) => TracksModel.fromJsonWithPreferences(track))
          .toList();
    } else {
      mountainTracks = [];
    }

    if (json['mountainMarks'] != null) {
      mountainMarks = (json['mountainMarks'] as List)
          .map((mark) => MarksModel.fromJson(mark))
          .toList();
    } else {
      mountainMarks = [];
    }

    if (json['mountainWaterfalls'] != null) {
      mountainWaterfalls = (json['mountainWaterfalls'] as List)
          .map((waterfall) => WaterfallsModel.fromJson(waterfall))
          .toList();
    } else {
      mountainWaterfalls = [];
    }

    if (json['mountainWatersprings'] != null) {
      mountainWatersprings = (json['mountainWatersprings'] as List)
          .map((waterspring) => WaterspringsModel.fromJson(waterspring))
          .toList();
    } else {
      mountainWatersprings = [];
    }

    if (json['mountainRivers'] != null) {
      mountainRivers = (json['mountainRivers'] as List)
          .map((river) => RiversModel.fromJson(river))
          .toList();
    } else {
      mountainRivers = [];
    }

    if (json['mountainPosts'] != null) {
      mountainPosts = (json['mountainPosts'] as List)
          .map((post) => PostsModel.fromJson(post))
          .toList();
    } else {
      mountainPosts = [];
    }

    CityModel city;
    if (json['city'] != null) {
      city = CityModel.fromJson(json['city']);
    } else {
      city = CityModel.fromJson(const {});
    }

    ProvinceModel province;
    if (json['province'] != null) {
      province = ProvinceModel.fromJson(json['province']);
    } else {
      province = ProvinceModel.fromJson(const {});
    }

    return MountainsModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      isMapOffline: json['isMapOffline'] ?? '',
      city: city,
      province: province,
      height: json['height'] ?? '',
      status: json['status'] ?? '',
      description: json['description'] ?? '',
      mountainImages: mountainImages,
      mountainPeaks: mountainPeaks,
      mountainTracks: mountainTracks,
      mountainMarks: mountainMarks,
      mountainWaterfalls: mountainWaterfalls,
      mountainWatersprings: mountainWatersprings,
      mountainRivers: mountainRivers,
      mountainPosts: mountainPosts,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'isMapOffline': isMapOffline,
      'city': city.toJson(),
      'province': province.toJson(),
      'height': height,
      'status': status,
      'description': description,
      'mountainTracks': mountainTracks.map((e) => e.toJson()).toList(),
      'mountainImages': mountainImages.map((e) => e.toJson()).toList(),
      'mountainPeaks': mountainPeaks.map((e) => e.toJson()).toList(),
      'mountainMarks': mountainMarks.map((e) => e.toJson()).toList(),
      'mountainWaterfalls': mountainWaterfalls.map((e) => e.toJson()).toList(),
      'mountainRivers': mountainRivers.map((e) => e.toJson()).toList(),
      'mountainPosts': mountainPosts.map((e) => e.toJson()).toList(),
      'mountainWatersprings':
          mountainWatersprings.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        latitude,
        longitude,
        isMapOffline,
        city,
        province,
        height,
        status,
        description,
        mountainImages,
        mountainPeaks,
        mountainMarks,
        mountainWaterfalls,
        mountainRivers,
        mountainPosts,
      ];
}
