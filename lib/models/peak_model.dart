import 'package:equatable/equatable.dart';

class PeakModel extends Equatable {
  final String id;
  final String name;
  final String height;
  final String latitude;
  final String longitude;
  final String status;
  final String userId;
  final String description;
  final String createdAt;
  final String updatedAt;

  const PeakModel({
    required this.id,
    this.name = '',
    this.height = '',
    this.latitude = '',
    this.longitude = '',
    this.status = '',
    this.userId = '',
    this.description = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory PeakModel.fromJson(Map<String, dynamic> json) => PeakModel(
        id: json['id'].toString(),
        name: json['name'] ?? '',
        height: json['height'] ?? '',
        latitude: json['latitude'] ?? '',
        longitude: json['longitude'] ?? '',
      );

  factory PeakModel.fromJsonWithPreferences(Map<String, dynamic> json) =>
      PeakModel(
        id: json['id'].toString(),
        name: json['name'] ?? '',
        height: json['height'] ?? '',
        latitude: json['latitude'] ?? '',
        longitude: json['longitude'] ?? '',
        status: json['status'] ?? '',
        userId: json['user_id'] ?? '',
        description: json['description'] ?? '',
        createdAt: json['created_at'] ?? '',
        updatedAt: json['updated_at'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'height': height,
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        height,
        latitude,
        longitude,
      ];
}
