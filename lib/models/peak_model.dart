import 'package:equatable/equatable.dart';

class PeakModel extends Equatable {
  final String id;
  final String name;
  final String height;
  final String latitude;
  final String longitude;

  const PeakModel({
    required this.id,
    this.name = '',
    this.height = '',
    this.latitude = '',
    this.longitude = '',
  });

  factory PeakModel.fromJson(Map<String, dynamic> json) => PeakModel(
        id: json['id'].toString(),
        name: json['name'],
        height: json['height'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  @override
  List<Object?> get props => [id, name, height, latitude, longitude];
}
