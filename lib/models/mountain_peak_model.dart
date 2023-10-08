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
    return MountainPeakModel(
      id: json['id'].toString(),
      status: json['status'],
      peak: PeakModel.fromJson(json['peak']),
    );
  }

  @override
  List<Object?> get props => [id, status, peak];
}
