import 'package:equatable/equatable.dart';

class PeakModel extends Equatable {
  final String id;
  final String name;
  final String height;

  const PeakModel({
    required this.id,
    this.name = '',
    this.height = '',
  });

  factory PeakModel.fromJson(Map<String, dynamic> json) => PeakModel(
        id: json['id'].toString(),
        name: json['name'],
        height: json['height'],
      );

  @override
  List<Object?> get props => [id, name, height];
}