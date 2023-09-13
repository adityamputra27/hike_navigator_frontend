import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/province_model.dart';

class MountainsModel extends Equatable {
  final String id;
  final String name;
  final String latitude;
  final String longitude;
  final String city;
  final ProvinceModel province;
  final String height;
  final String status;
  final String description;

  const MountainsModel({
    required this.id,
    this.name = '',
    this.latitude = '',
    this.longitude = '',
    this.city = '',
    required this.province,
    this.height = '',
    this.status = '',
    this.description = '',
  });

  factory MountainsModel.fromJson(Map<String, dynamic> json) => MountainsModel(
        id: json['id'].toString(),
        name: json['name'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        city: json['city'].toString(),
        province: ProvinceModel.fromJson(
            json['province']['id'].toString(), json['province']),
        height: json['height'],
        status: json['status'],
        description: json['description'],
      );

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
