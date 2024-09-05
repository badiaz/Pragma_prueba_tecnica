import 'package:catbreeds/domain/entities/entities.dart';

part 'breed_entity.g.dart';

@JsonSerializable()
class BreedEntity {
  final String id;
  final String name;
  final WeightEntity weight;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'temperament')
  final String temperament;

  @JsonKey(name: 'origin')
  final String origin;

  @JsonKey(name: 'life_span')
  final String lifeSpan;

  @JsonKey(name: 'adaptability')
  final int adaptability;

  @JsonKey(name: 'affection_level')
  final int affectionLevel;

  @JsonKey(name: 'child_friendly')
  final int childFriendly;

  @JsonKey(name: 'dog_friendly')
  final int dogFriendly;

  @JsonKey(name: 'energy_level')
  final int energyLevel;

  @JsonKey(name: 'grooming')
  final int grooming;

  @JsonKey(name: 'health_issues')
  final int healthIssues;

  @JsonKey(name: 'intelligence')
  final int intelligence;

  @JsonKey(name: 'shedding_level')
  final int sheddingLevel;

  @JsonKey(name: 'social_needs')
  final int socialNeeds;

  @JsonKey(name: 'stranger_friendly')
  final int strangerFriendly;

  @JsonKey(name: 'vocalisation')
  final int vocalisation;

  @JsonKey(name: 'cfa_url')
  final String? cfaUrl;

  @JsonKey(name: 'vetstreet_url')
  final String? vetstreetUrl;

  @JsonKey(name: 'vcahospitals_url')
  final String? vcahospitalsUrl;

  @JsonKey(name: 'wikipedia_url')
  final String? wikipediaUrl;

  @JsonKey(name: 'hypoallergenic')
  final int hypoallergenic;

  final ImageEntity? image;

  BreedEntity(
      {required this.id,
      required this.name,
      required this.weight,
      required this.description,
      required this.temperament,
      required this.origin,
      required this.lifeSpan,
      required this.adaptability,
      required this.affectionLevel,
      required this.childFriendly,
      required this.dogFriendly,
      required this.energyLevel,
      required this.grooming,
      required this.healthIssues,
      required this.intelligence,
      required this.sheddingLevel,
      required this.socialNeeds,
      required this.strangerFriendly,
      required this.vocalisation,
      this.cfaUrl,
      this.vetstreetUrl,
      this.vcahospitalsUrl,
      this.wikipediaUrl,
      required this.hypoallergenic,
      this.image});

  factory BreedEntity.fromJson(Map<String, dynamic> json) =>
      _$BreedEntityFromJson(json);
  Map<String, dynamic> toJson() => _$BreedEntityToJson(this);
}
