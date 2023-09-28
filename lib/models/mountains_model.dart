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
      mountainImages: (json['mountain_images'] as List)
          .map((peaks) => MountainImagesModel.fromJson(peaks))
          .toList(),
      mountainPeaks: (json['mountain_peaks'] as List)
          .map((peaks) => MountainPeaksModel.fromJson(peaks))
          .toList(),
      mountainTracks: (json['mountain_tracks'] as List)
          .map((peaks) => TracksModel.fromJson(peaks))
          .toList(),
      mountainMarks: (json['mountain_marks'] as List)
          .map((peaks) => MarksModel.fromJson(peaks))
          .toList(),
      mountainWaterfalls: (json['mountain_waterfalls'] as List)
          .map((peaks) => WaterfallsModel.fromJson(peaks))
          .toList(),
      mountainWatersprings: (json['mountain_watersprings'] as List)
          .map((peaks) => WaterspringsModel.fromJson(peaks))
          .toList(),
      mountainRivers: (json['mountain_rivers'] as List)
          .map((peaks) => RiversModel.fromJson(peaks))
          .toList(),
      mountainPosts: (json['mountain_posts'] as List)
          .map((peaks) => PostsModel.fromJson(peaks))
          .toList(),
    );
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
      ];
}
