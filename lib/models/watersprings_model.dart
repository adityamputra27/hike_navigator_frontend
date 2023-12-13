import 'package:equatable/equatable.dart';

class WaterspringsModel extends Equatable {
  final String id;
  final String title;
  final String latitude;
  final String longitude;
  final String contactNumber;

  const WaterspringsModel({
    required this.id,
    this.title = '',
    this.latitude = '',
    this.longitude = '',
    this.contactNumber = '',
  });

  factory WaterspringsModel.fromJson(Map<String, dynamic> json) =>
      WaterspringsModel(
        id: json['id'].toString(),
        title: json['title'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        contactNumber: json['contact_number'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  List<Object?> get props => [id, title, latitude, longitude, contactNumber];
}
