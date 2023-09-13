import 'package:equatable/equatable.dart';

class ProvinceModel extends Equatable {
  final String id;
  final String name;

  const ProvinceModel({
    required this.id,
    this.name = '',
  });

  factory ProvinceModel.fromJson(String id, Map<String, dynamic> json) =>
      ProvinceModel(
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
