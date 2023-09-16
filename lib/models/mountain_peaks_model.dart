import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/peak_model.dart';

class MountainPeaksModel extends Equatable {
  final String id;
  final String status;
  final PeakModel peak;

  const MountainPeaksModel({
    required this.id,
    this.status = '',
    required this.peak,
  });

  factory MountainPeaksModel.fromJson(Map<String, dynamic> json) =>
      MountainPeaksModel(
        id: json['id'].toString(),
        status: json['status'],
        peak: PeakModel.fromJson(json['peak']['id'].toString(), json['peak']),
      );

  @override
  List<Object?> get props => [id, status, peak];
}
