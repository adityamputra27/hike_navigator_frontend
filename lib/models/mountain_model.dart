import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/city_model.dart';
import 'package:hike_navigator/models/mountain_images_model.dart';
import 'package:hike_navigator/models/province_model.dart';

class MountainModel extends Equatable {
  final String id;
  final String name;
  final String height;
  final String latitude;
  final String longitude;
  final String isMapOffline;
  final String description;
  final CityModel city;
  final ProvinceModel province;
  final List<MountainImagesModel> mountainImages;

  const MountainModel({
    required this.id,
    this.name = '',
    this.height = '',
    this.latitude = '',
    this.longitude = '',
    this.isMapOffline = '',
    this.description = '',
    required this.city,
    required this.province,
    required this.mountainImages,
  });

  factory MountainModel.fromJson(Map<String, dynamic> json) {
    return MountainModel(
      id: json['id'].toString(),
      name: json['name'],
      height: json['height'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isMapOffline: json['is_map_offline'],
      description: json['description'],
      city: CityModel.fromJson(json['city']),
      province: ProvinceModel.fromJson(json['province']),
      mountainImages: (json['mountain_images'] as List)
          .map((image) => MountainImagesModel.fromJson(image))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        height,
        latitude,
        longitude,
        isMapOffline,
        description,
        city,
        province,
        mountainImages,
      ];
}
