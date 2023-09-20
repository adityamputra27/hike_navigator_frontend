import 'package:equatable/equatable.dart';

class ProvinceModel extends Equatable {
  final String id;
  final String name;

  const ProvinceModel({
    required this.id,
    this.name = '',
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
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
