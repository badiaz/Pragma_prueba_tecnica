import 'package:catbreeds/data/repository/cat_api_repository.dart';
import 'package:catbreeds/domain/use_cases/filter_breeds_use_case.dart';
import 'package:catbreeds/domain/use_cases/get_breeds_use_case.dart';
import 'package:injector/injector.dart';

class DependencyInjection {
  static final Injector injector = Injector();

  static void initialize() {
    _registerRepositories();
    _registerUseCases();
  }

  static void _registerRepositories() {
    injector.registerSingleton<CatApiRepository>(() => CatApiRepository());
  }

  static void _registerUseCases() {
    injector.registerSingleton<GetBreedsUseCase>(() {
      final catApiRepository = injector.get<CatApiRepository>();
      return GetBreedsUseCase(catApiRepository: catApiRepository);
    });
    injector.registerSingleton<FilterBreedsUseCase>(() {
      final catApiRepository = injector.get<CatApiRepository>();
      return FilterBreedsUseCase(catApiRepository: catApiRepository);
    });
  }

  static T get<T>() {
    return injector.get<T>();
  }
}
