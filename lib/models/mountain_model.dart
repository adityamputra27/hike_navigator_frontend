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
  final String status;
  final String cityId;
  final String provinceId;
  final String userId;
  final String createdAt;
  final String updatedAt;
  final CityModel? city;
  final ProvinceModel? province;
  final List<MountainImagesModel>? mountainImages;

  const MountainModel({
    required this.id,
    this.name = '',
    this.height = '',
    this.latitude = '',
    this.longitude = '',
    this.isMapOffline = '',
    this.description = '',
    this.status = '',
    this.cityId = '',
    this.provinceId = '',
    this.userId = '',
    this.createdAt = '',
    this.updatedAt = '',
    this.city,
    this.province,
    this.mountainImages,
  });

  factory MountainModel.fromJson(Map<String, dynamic> json) {
    List<MountainImagesModel> mountainImages = [];
    if (json['mountain_images'] != null) {
      mountainImages = (json['mountain_images'] as List)
          .map((image) => MountainImagesModel.fromJson(image))
          .toList();
    }

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
      mountainImages: mountainImages,
    );
  }

  factory MountainModel.fromJsonWithPreferences(Map<String, dynamic> json) {
    return MountainModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      height: json['height'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      isMapOffline: json['is_map_offline'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      cityId: json['city_id'] ?? '',
      provinceId: json['province_id'] ?? '',
      userId: json['user_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
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
