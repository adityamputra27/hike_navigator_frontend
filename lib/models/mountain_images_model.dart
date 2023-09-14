import 'package:equatable/equatable.dart';

class MountainImagesModel extends Equatable {
  final String id;
  final String url;

  const MountainImagesModel({
    required this.id,
    this.url = '',
  });

  factory MountainImagesModel.fromJson(Map<String, dynamic> json) =>
      MountainImagesModel(
        id: json['id'].toString(),
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
      };

  @override
  List<Object?> get props => throw UnimplementedError();
}
