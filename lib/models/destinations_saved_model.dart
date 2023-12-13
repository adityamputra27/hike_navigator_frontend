import 'package:equatable/equatable.dart';
import 'package:hike_navigator/models/mountains_model.dart';

class DestinationsSavedModel extends Equatable {
  final String id;
  final MountainsModel mountain;
  final String status;

  const DestinationsSavedModel({
    required this.id,
    required this.mountain,
    this.status = '',
  });

  factory DestinationsSavedModel.fromJsonRequest(Map<String, dynamic> json) {
    return DestinationsSavedModel(
      id: json['id'].toString(),
      mountain: MountainsModel.fromJson(json['mountain']),
      status: json['status'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        mountain,
        status,
      ];
}
