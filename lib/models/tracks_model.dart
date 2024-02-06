import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/marks_model.dart';
import 'package:hike_navigator/models/posts_model.dart';
import 'package:hike_navigator/models/rivers_model.dart';
import 'package:hike_navigator/models/waterfalls_model.dart';
import 'package:hike_navigator/models/watersprings_model.dart';

class TracksModel extends Equatable {
  final String id;
  final String title;
  final String time;
  final String latitude;
  final String longitude;
  final String coordinates;
  final String startLatitude;
  final String startLongitude;
  final List<MarksModel> marks;
  final List<WaterfallsModel> waterfalls;
  final List<WaterspringsModel> watersprings;
  final List<RiversModel> rivers;
  final List<PostsModel> posts;

  const TracksModel({
    required this.id,
    this.title = '',
    this.time = '0',
    this.latitude = '',
    this.longitude = '',
    this.coordinates = '',
    this.startLatitude = '',
    this.startLongitude = '',
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
      title: json['title'].toString(),
      time: json['time'].toString(),
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
      coordinates: json['coordinates'],
      startLatitude: json['start_latitude'].toString(),
      startLongitude: json['start_longitude'].toString(),
      marks: marks,
      waterfalls: waterfalls,
      watersprings: watersprings,
      rivers: rivers,
      posts: posts,
    );
  }

  factory TracksModel.fromJsonWithPreferences(Map<String, dynamic> json) {
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
      title: json['title'].toString(),
      time: json['time'].toString(),
      latitude: json['latitude'].toString(),
      longitude: json['longitude'].toString(),
      coordinates: json['coordinates'],
      startLatitude: json['startLatitude'].toString(),
      startLongitude: json['startLongitude'].toString(),
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
        'time': time,
        'latitude': latitude,
        'longitude': longitude,
        'coordinates': coordinates,
        'startLatitude': startLatitude,
        'startLongitude': startLongitude,
        'marks': marks.map((e) => e.toJson()).toList(),
        'waterfalls': waterfalls.map((e) => e.toJson()).toList(),
        'watersprings': watersprings.map((e) => e.toJson()).toList(),
        'rivers': rivers.map((e) => e.toJson()).toList(),
        'posts': posts.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [
        id,
        title,
        time,
        latitude,
        longitude,
        coordinates,
        startLatitude,
        startLongitude,
        marks,
        waterfalls,
        watersprings,
        rivers,
        posts
      ];
}
