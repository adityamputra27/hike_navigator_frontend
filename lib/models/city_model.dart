import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final String id;
  final String name;

  const CityModel({
    required this.id,
    this.name = '',
  });

  factory CityModel.fromJson(String id, Map<String, dynamic> json) => CityModel(
        id: id,
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  List<Object?> get props => throw UnimplementedError();
}
