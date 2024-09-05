import 'package:catbreeds/data/repository/cat_api_repository.dart';
import 'package:catbreeds/domain/entities/breed_entity.dart';

abstract class IFilterBreedsUseCase {
  Future<List<BreedEntity>> searchBreeds({required String query});
}

class FilterBreedsUseCase implements IFilterBreedsUseCase {
  final ICatApiRepository catApiRepository;

  FilterBreedsUseCase({required this.catApiRepository});
  @override
  Future<List<BreedEntity>> searchBreeds({required String query}) {
    return catApiRepository.searchBreeds(query: query);
  }
}
