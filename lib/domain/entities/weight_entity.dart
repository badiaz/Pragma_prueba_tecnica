import 'package:json_annotation/json_annotation.dart';

part 'weight_entity.g.dart';

@JsonSerializable()
class WeightEntity {
  final String imperial;
  final String metric;

  WeightEntity({required this.imperial, required this.metric});

  factory WeightEntity.fromJson(Map<String, dynamic> json) =>
      _$WeightEntityFromJson(json);
  Map<String, dynamic> toJson() => _$WeightEntityToJson(this);
}
