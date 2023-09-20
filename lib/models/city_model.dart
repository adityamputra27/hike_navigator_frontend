import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final String id;
  final String name;

  const CityModel({
    required this.id,
    this.name = '',
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'].toString(),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  List<Object?> get props => [id, name];
}
