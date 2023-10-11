import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/mountain_model.dart';
import 'package:hike_navigator/models/peak_model.dart';
import 'package:hike_navigator/models/tracks_model.dart';

class MountainPeaksModel extends Equatable {
  final String id;
  final String status;
  final MountainModel mountain;
  final PeakModel peak;
  final List<TracksModel> tracks;

  const MountainPeaksModel({
    required this.id,
    this.status = '',
    required this.mountain,
    required this.peak,
    required this.tracks,
  });

  factory MountainPeaksModel.fromJson(Map<String, dynamic> json) {
    MountainModel mountain;
    if (json['mountain'] != null) {
      mountain = MountainModel.fromJsonWithPreferences(json['mountain']);
    } else {
      mountain = MountainModel.fromJsonWithPreferences(const {});
    }

    return MountainPeaksModel(
      id: json['id'].toString(),
      status: json['status'],
      mountain: mountain,
      peak: PeakModel.fromJsonWithPreferences(json['peak']),
      tracks: (json['tracks'] as List)
          .map((track) => TracksModel.fromJsonWithPreferences(track))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'peak': peak.toJson(),
      'tracks': tracks.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, status, peak];
}
