import 'package:equatable/equatable.dart';

class WaterspringsModel extends Equatable {
  final String id;
  final String title;
  final String latitude;
  final String longitude;

  const WaterspringsModel({
    required this.id,
    this.title = '',
    this.latitude = '',
    this.longitude = '',
  });

  factory WaterspringsModel.fromJson(Map<String, dynamic> json) =>
      WaterspringsModel(
        id: json['id'].toString(),
        title: json['title'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  List<Object?> get props => [id, title, latitude, longitude];
}
