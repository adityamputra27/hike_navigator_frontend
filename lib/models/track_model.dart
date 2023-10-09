import 'package:equatable/equatable.dart';

class TrackModel extends Equatable {
  final String id;
  final String title;
  final String latitude;
  final String longitude;
  final String geojson;
  final String coordinates;
  final String startLatitude;
  final String startLongitude;

  const TrackModel({
    required this.id,
    this.title = '',
    this.latitude = '',
    this.longitude = '',
    this.geojson = '',
    this.coordinates = '',
    this.startLatitude = '',
    this.startLongitude = '',
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      id: json['id'].toString(),
      title: json['title'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      geojson: json['geojson'],
      coordinates: json['coordinates'],
      startLatitude: json['start_latitude'] ?? '',
      startLongitude: json['start_longitude'] ?? '',
    );
  }

  factory TrackModel.fromJsonWithPreferences(Map<String, dynamic> json) {
    return TrackModel(
      id: json['id'].toString(),
      title: json['title'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      geojson: json['geojson'],
      coordinates: json['coordinates'],
      startLatitude: json['startLatitude'] ?? '',
      startLongitude: json['startLongitude'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'latitude': latitude,
        'longitude': longitude,
        'geojson': geojson,
        'coordinates': coordinates,
        'startLatitude': startLatitude,
        'startLongitude': startLongitude,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        latitude,
        longitude,
        geojson,
        coordinates,
        startLatitude,
        startLongitude,
      ];
}
