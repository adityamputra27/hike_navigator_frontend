import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/mountain_peak_model.dart';
import 'package:hike_navigator/models/mountains_model.dart';
import 'package:hike_navigator/models/track_model.dart';

class DestinationsModel extends Equatable {
  final String id;
  final String scheduleDate;
  final MountainsModel mountain;
  final MountainPeakModel mountainPeak;
  final TrackModel track;
  final String status;

  const DestinationsModel({
    required this.id,
    this.scheduleDate = '',
    required this.mountain,
    this.status = '',
    required this.mountainPeak,
    required this.track,
  });

  factory DestinationsModel.fromJsonRequest(Map<String, dynamic> json) {
    MountainPeakModel mountainPeak;

    if (json['mountain_peak'] != null) {
      mountainPeak = MountainPeakModel.fromJson(json['mountain_peak']);
    } else {
      mountainPeak = MountainPeakModel.fromJson(const {});
    }

    return DestinationsModel(
      id: json['id'].toString(),
      scheduleDate: json['schedule_date'].toString(),
      mountain: MountainsModel.fromJson(json['mountain']),
      status: json['status'],
      mountainPeak: mountainPeak,
      track: TrackModel.fromJson(json['track']),
    );
  }

  factory DestinationsModel.fromJson(Map<String, dynamic> json) {
    MountainPeakModel mountainPeak;

    if (json['mountain_peak'] != null) {
      mountainPeak = MountainPeakModel.fromJson(json['mountain_peak']);
    } else {
      mountainPeak = MountainPeakModel.fromJson(const {});
    }

    return DestinationsModel(
      id: json['id'].toString(),
      scheduleDate: json['schedule_date'].toString(),
      mountain: MountainsModel.fromJsonWithPreferences(json['mountain']),
      status: json['status'],
      mountainPeak: mountainPeak,
      track: TrackModel.fromJson(json['track']),
    );
  }

  factory DestinationsModel.fromJsonWithPreferences(Map<String, dynamic> json) {
    MountainPeakModel mountainPeak;

    if (json['mountainPeak'] != null) {
      mountainPeak =
          MountainPeakModel.fromJsonPreferences(json['mountainPeak']);
    } else {
      mountainPeak = MountainPeakModel.fromJsonPreferences(const {});
    }

    TrackModel track;
    if (json['track'] != null) {
      track = TrackModel.fromJsonWithPreferences(json['track']);
    } else {
      track = TrackModel.fromJsonWithPreferences(const {});
    }

    MountainsModel mountain;
    if (json['mountain'] != null) {
      mountain = MountainsModel.fromJsonWithPreferences(json['mountain']);
    } else {
      mountain = MountainsModel.fromJsonWithPreferences(const {});
    }

    return DestinationsModel(
      id: json['id'].toString(),
      scheduleDate: json['scheduleDate'].toString(),
      status: json['status'] ?? '',
      mountainPeak: mountainPeak,
      track: track,
      mountain: mountain,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scheduleDate': scheduleDate,
      'mountain': mountain.toJson(),
      'status': status,
      'mountainPeak': mountainPeak.toJson(),
      'track': track.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        scheduleDate,
        mountain,
        status,
      ];
}
