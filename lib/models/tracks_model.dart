import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/marks_model.dart';
import 'package:hike_navigator/models/posts_model.dart';
import 'package:hike_navigator/models/rivers_model.dart';
import 'package:hike_navigator/models/waterfalls_model.dart';
import 'package:hike_navigator/models/watersprings_model.dart';

class TracksModel extends Equatable {
  final String id;
  final String title;
  final String latitude;
  final String longitude;
  final String geojson;
  final String coordinates;
  final List<MarksModel> marks;
  final List<WaterfallsModel> waterfalls;
  final List<WaterspringsModel> watersprings;
  final List<RiversModel> rivers;
  final List<PostsModel> posts;

  const TracksModel({
    required this.id,
    this.title = '',
    this.latitude = '',
    this.longitude = '',
    this.geojson = '',
    this.coordinates = '',
    required this.marks,
    required this.waterfalls,
    required this.watersprings,
    required this.rivers,
    required this.posts,
  });

  factory TracksModel.fromJson(Map<String, dynamic> json) {
    List<MarksModel> marks = [];
    if (json['marks'] != null) {
      marks = (json['marks'] as List)
          .map((mark) => MarksModel.fromJson(mark))
          .toList();
    }

    List<WaterfallsModel> waterfalls = [];
    if (json['waterfalls'] != null) {
      waterfalls = (json['waterfalls'] as List)
          .map((waterfall) => WaterfallsModel.fromJson(waterfall))
          .toList();
    }

    List<WaterspringsModel> watersprings = [];
    if (json['watersprings'] != null) {
      watersprings = (json['watersprings'] as List)
          .map((waterspring) => WaterspringsModel.fromJson(waterspring))
          .toList();
    }

    List<RiversModel> rivers = [];
    if (json['rivers'] != null) {
      rivers = (json['rivers'] as List)
          .map((river) => RiversModel.fromJson(river))
          .toList();
    }

    List<PostsModel> posts = [];
    if (json['posts'] != null) {
      posts = (json['posts'] as List)
          .map((post) => PostsModel.fromJson(post))
          .toList();
    }

    return TracksModel(
      id: json['id'].toString(),
      title: json['title'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      geojson: json['geojson'],
      coordinates: json['coordinates'],
      marks: marks,
      waterfalls: waterfalls,
      watersprings: watersprings,
      rivers: rivers,
      posts: posts,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'latitude': latitude,
        'longitude': longitude,
      };

  @override
  List<Object?> get props => [
        id,
        title,
        latitude,
        longitude,
        marks,
        waterfalls,
        watersprings,
        rivers,
        posts
      ];
}
