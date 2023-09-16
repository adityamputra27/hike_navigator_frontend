import 'package:equatable/equatable.dart';

class PostsModel extends Equatable {
  final String id;
  final String title;
  final String latitude;
  final String longitude;

  const PostsModel({
    required this.id,
    this.title = '',
    this.latitude = '',
    this.longitude = '',
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
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
