import 'package:equatable/equatable.dart';

class MarksModel extends Equatable {
  final String id;
  final String title;
  final String latitude;
  final String longitude;

  const MarksModel({
    required this.id,
    this.title = '',
    this.latitude = '',
    this.longitude = '',
  });

  factory MarksModel.fromJson(Map<String, dynamic> json) => MarksModel(
        id: json['id'].toString(),
        title: json['title'] ?? '',
        latitude: json['latitude'] ?? '',
        longitude: json['longitude'] ?? '',
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
