import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/peak_model.dart';

class MountainPeakModel extends Equatable {
  final String id;
  final String status;
  final PeakModel peak;

  const MountainPeakModel({
    required this.id,
    this.status = '',
    required this.peak,
  });

  factory MountainPeakModel.fromJson(Map<String, dynamic> json) {
    PeakModel peak;

    if (json['peak'] != null) {
      peak = PeakModel.fromJson(json['peak']);
    } else {
      peak = PeakModel.fromJson(const {});
    }

    return MountainPeakModel(
      id: json['id'].toString(),
      status: json['status'] ?? '',
      peak: peak,
    );
  }

  factory MountainPeakModel.fromJsonPreferences(Map<String, dynamic> json) {
    PeakModel peak;

    if (json['peak'] != null) {
      peak = PeakModel.fromJson(json['peak']);
    } else {
      peak = PeakModel.fromJson(const {});
    }

    return MountainPeakModel(
      id: json['id'].toString(),
      status: json['status'] ?? '',
      peak: peak,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'peak': peak.toJson(),
      };

  @override
  List<Object?> get props => [id, status, peak];
}
