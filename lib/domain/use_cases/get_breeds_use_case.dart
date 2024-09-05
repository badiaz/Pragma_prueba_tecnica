import 'package:catbreeds/domain/entities/entities.dart';
import 'package:catbreeds/data/repository/cat_api_repository.dart';

abstract class IGetBreedsUseCase {
  Future<List<BreedEntity>> getBreeds({required int page});
}

class GetBreedsUseCase implements IGetBreedsUseCase {
  final ICatApiRepository catApiRepository;

  GetBreedsUseCase({required this.catApiRepository});
  @override
  Future<List<BreedEntity>> getBreeds({required int page}) {
    return catApiRepository.getBreeds(page: page);
  }
}
