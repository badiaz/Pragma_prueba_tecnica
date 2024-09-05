// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreedEntity _$BreedEntityFromJson(Map<String, dynamic> json) => BreedEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      weight: WeightEntity.fromJson(json['weight'] as Map<String, dynamic>),
      description: json['description'] as String,
      temperament: json['temperament'] as String,
      origin: json['origin'] as String,
      lifeSpan: json['life_span'] as String,
      adaptability: (json['adaptability'] as num).toInt(),
      affectionLevel: (json['affection_level'] as num).toInt(),
      childFriendly: (json['child_friendly'] as num).toInt(),
      dogFriendly: (json['dog_friendly'] as num).toInt(),
      energyLevel: (json['energy_level'] as num).toInt(),
      grooming: (json['grooming'] as num).toInt(),
      healthIssues: (json['health_issues'] as num).toInt(),
      intelligence: (json['intelligence'] as num).toInt(),
      sheddingLevel: (json['shedding_level'] as num).toInt(),
      socialNeeds: (json['social_needs'] as num).toInt(),
      strangerFriendly: (json['stranger_friendly'] as num).toInt(),
      vocalisation: (json['vocalisation'] as num).toInt(),
      cfaUrl: json['cfa_url'] as String?,
      vetstreetUrl: json['vetstreet_url'] as String?,
      vcahospitalsUrl: json['vcahospitals_url'] as String?,
      wikipediaUrl: json['wikipedia_url'] as String?,
      hypoallergenic: (json['hypoallergenic'] as num).toInt(),
      image: json['image'] == null
          ? null
          : ImageEntity.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BreedEntityToJson(BreedEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'weight': instance.weight,
      'description': instance.description,
      'temperament': instance.temperament,
      'origin': instance.origin,
      'life_span': instance.lifeSpan,
      'adaptability': instance.adaptability,
      'affection_level': instance.affectionLevel,
      'child_friendly': instance.childFriendly,
      'dog_friendly': instance.dogFriendly,
      'energy_level': instance.energyLevel,
      'grooming': instance.grooming,
      'health_issues': instance.healthIssues,
      'intelligence': instance.intelligence,
      'shedding_level': instance.sheddingLevel,
      'social_needs': instance.socialNeeds,
      'stranger_friendly': instance.strangerFriendly,
      'vocalisation': instance.vocalisation,
      'cfa_url': instance.cfaUrl,
      'vetstreet_url': instance.vetstreetUrl,
      'vcahospitals_url': instance.vcahospitalsUrl,
      'wikipedia_url': instance.wikipediaUrl,
      'hypoallergenic': instance.hypoallergenic,
      'image': instance.image,
    };
