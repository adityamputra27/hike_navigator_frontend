import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/city_model.dart';
import 'package:hike_navigator/models/mountain_images_model.dart';
import 'package:hike_navigator/models/province_model.dart';

class MountainsModel extends Equatable {
  final String id;
  final String name;
  final String latitude;
  final String longitude;
  final CityModel city;
  final ProvinceModel province;
  final String height;
  final String status;
  final String description;
  final List<MountainImagesModel> mountainImages;

  const MountainsModel({
    required this.id,
    this.name = '',
    this.latitude = '',
    this.longitude = '',
    required this.city,
    required this.province,
    this.height = '',
    this.status = '',
    this.description = '',
    required this.mountainImages,
  });

  factory MountainsModel.fromJson(Map<String, dynamic> json) => MountainsModel(
      id: json['id'].toString(),
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      city: CityModel.fromJson(json['city']['id'].toString(), json['city']),
      province: ProvinceModel.fromJson(
          json['province']['id'].toString(), json['province']),
      height: json['height'],
      status: json['status'],
      description: json['description'],
      mountainImages: (json['mountain_images'] as List)
          .map((image) => MountainImagesModel.fromJson(image))
          .toList());

  @override
  List<Object?> get props => [
        id,
        name,
        latitude,
        longitude,
        city,
        province,
        height,
        status,
        description,
      ];
}
