import 'package:catbreeds/domain/entities/breed_entity.dart';
import 'package:catbreeds/domain/use_cases/filter_breeds_use_case.dart';
import 'package:catbreeds/domain/use_cases/get_breeds_use_case.dart';
import 'package:catbreeds/presentation/screens/cat_detail_screen.dart';
import 'package:catbreeds/presentation/screens/home_screen.dart';
import 'package:catbreeds/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catbreeds/di/dependecy_injection.dart';
import 'package:catbreeds/presentation/blocs/blocs.dart';
import 'package:catbreeds/presentation/blocs/breed/breed_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  DependencyInjection.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => BreedBloc(
                getBreedsUseCase: DependencyInjection.get<GetBreedsUseCase>(),
                filterBreedsUseCase:
                    DependencyInjection.get<FilterBreedsUseCase>())
              ..add(const FetchBreedsEvent(page: 0)))
      ],
      child: MaterialApp(
        title: 'Catsbreed',
        theme: ThemeData(
            fontFamily: 'Ubuntu',
            textSelectionTheme: TextSelectionThemeData(
                cursorColor: AppColors.primaryGreenColor,
                selectionColor: Colors.grey[300],
                selectionHandleColor: AppColors.primaryGreenColor)),
        onGenerateRoute: (page) {
          if (page.name == 'catDetail') {
            final BreedEntity catInfo = page.arguments as BreedEntity;
            return MaterialPageRoute(
                builder: (context) => CatDetailScreen(
                      catInfo: catInfo,
                    ));
          }
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        },
        home: const Scaffold(
          body: HomeScreen(),
        ),
      ),
    );
  }
}
