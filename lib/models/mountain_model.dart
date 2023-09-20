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
    required this.city,
    required this.province,
    required this.mountainImages,
  });

  factory MountainModel.fromJson(String id, Map<String, dynamic> json) =>
      MountainModel(
        id: id,
        name: json['name'],
        height: json['height'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        isMapOffline: json['is_map_offline'],
        city: CityModel.fromJson(json['city']['id'].toString(), json['city']),
        province: ProvinceModel.fromJson(
            json['province']['id'].toString(), json['province']),
        mountainImages: (json['mountain_images'] as List)
            .map((image) => MountainImagesModel.fromJson(image))
            .toList(),
      );

  @override
  List<Object?> get props => [
        id,
        name,
        height,
        latitude,
        longitude,
        isMapOffline,
        city,
        province,
        mountainImages,
      ];
}
