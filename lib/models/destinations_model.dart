import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/mountain_model.dart';

class DestinationsModel extends Equatable {
  final String id;
  final String scheduleDate;
  final MountainModel mountain;

  const DestinationsModel({
    required this.id,
    this.scheduleDate = '',
    required this.mountain,
  });

  factory DestinationsModel.fromJson(Map<String, dynamic> json) =>
      DestinationsModel(
        id: json['id'].toString(),
        scheduleDate: json['schedule_date'].toString(),
        mountain: MountainModel.fromJson(json['mountain']),
      );

  @override
  List<Object?> get props => [
        id,
        scheduleDate,
        mountain,
      ];
}
