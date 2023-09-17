import 'package:equatable/equatable.dart';

class MountainModel extends Equatable {
  final String id;
  final String name;
  final String height;
  final String latitude;
  final String longitude;
  final String isMapOffline;

  const MountainModel({
    required this.id,
    this.name = '',
    this.height = '',
    this.latitude = '',
    this.longitude = '',
    this.isMapOffline = '',
  });

  factory MountainModel.fromJson(String id, Map<String, dynamic> json) =>
      MountainModel(
        id: id,
        name: json['name'],
        height: json['height'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        isMapOffline: json['is_map_offline'],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        height,
        latitude,
        longitude,
        isMapOffline,
      ];
}
