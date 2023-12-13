import 'package:equatable/equatable.dart';

class CrossRoadsModel extends Equatable {
  final String id;
  final String title;
  final String latitude;
  final String longitude;
  final String contactNumber;

  const CrossRoadsModel({
    required this.id,
    this.title = '',
    this.latitude = '',
    this.longitude = '',
    this.contactNumber = '',
  });

  factory CrossRoadsModel.fromJson(Map<String, dynamic> json) =>
      CrossRoadsModel(
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
