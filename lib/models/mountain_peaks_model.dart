import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/peak_model.dart';
import 'package:hike_navigator/models/tracks_model.dart';

class MountainPeaksModel extends Equatable {
  final String id;
  final String status;
  final PeakModel peak;
  final List<TracksModel> tracks;

  const MountainPeaksModel({
    required this.id,
    this.status = '',
    required this.peak,
    required this.tracks,
  });

  factory MountainPeaksModel.fromJson(Map<String, dynamic> json) {
    List<TracksModel> tracks = [];
    if (json['tracks'] != null) {
      tracks = (json['tracks'] as List<dynamic>)
          .map((track) => TracksModel.fromJson(track))
          .toList();
    }

    return MountainPeaksModel(
      id: json['id'].toString(),
      status: json['status'],
      peak: PeakModel.fromJson(json['peak']['id'].toString(), json['peak']),
      tracks: tracks,
    );
  }

  @override
  List<Object?> get props => [id, status, peak, tracks];
}
