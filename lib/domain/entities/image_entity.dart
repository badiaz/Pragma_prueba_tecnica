import 'package:json_annotation/json_annotation.dart';

part 'image_entity.g.dart';

@JsonSerializable()
class ImageEntity {
  final String id;
  final int width;
  final int height;
  final String url;

  ImageEntity({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
  });

  factory ImageEntity.fromJson(Map<String, dynamic> json) =>
      _$ImageEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ImageEntityToJson(this);
}
