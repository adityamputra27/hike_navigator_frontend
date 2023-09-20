import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/city_model.dart';
import 'package:hike_navigator/models/mountain_images_model.dart';
import 'package:hike_navigator/models/mountain_peaks_model.dart';
import 'package:hike_navigator/models/province_model.dart';

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
