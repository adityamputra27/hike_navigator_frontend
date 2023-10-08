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

  factory DestinationsModel.fromJson(Map<String, dynamic> json) {
    return DestinationsModel(
      id: json['id'].toString(),
      scheduleDate: json['schedule_date'].toString(),
      mountain: MountainsModel.fromJson(json['mountain']),
      status: json['status'],
      mountainPeak: MountainPeakModel.fromJson(json['mountain_peak']),
      track: TrackModel.fromJson(json['track']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schedule_date': scheduleDate,
      'mountain': mountain,
      'status': status,
      'mountain_peak': mountainPeak,
      'track': track,
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
