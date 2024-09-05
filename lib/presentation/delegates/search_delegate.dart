import 'package:flutter/material.dart';
import 'package:catbreeds/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catbreeds/presentation/blocs/breed/breed_bloc.dart';

class BreedSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Search a cat breed';
  @override
  TextStyle get searchFieldStyle => const TextStyle(
        fontSize: 16.0,
        color: Colors.grey,
      );
  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return [
        IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear),
        ),
      ];
    } else {
      return [];
    }
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        BlocProvider.of<BreedBloc>(context).add(ClearSearchResultsEvent());
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final bloc = BlocProvider.of<BreedBloc>(context);

    bloc.add(SearchBreedsEvent(query));

    return BlocBuilder<BreedBloc, BreedState>(
      builder: (context, state) {
        if (state is BreedLoadingState) {
          return Container(
            color: AppColors.greyBackgroundColor,
            child: Center(
                child: CircularProgressIndicator(
              color: AppColors.primaryGreenColor,
            )),
          );
        } else if (state is BreedLoadedState && state.searchResults != null) {
          final results = state.searchResults!;

          if (results.isEmpty) {
            return Container(
                color: AppColors.greyBackgroundColor,
                child: Center(
                  child: Text('No breeds found.',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500])),
                ));
          }

          return Container(
            color: AppColors.greyBackgroundColor,
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final breed = results[index];
                return ListTile(
                  leading: Hero(
                    tag: breed.id,
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      child: FadeInImage(
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 300),
                        placeholder:
                            const AssetImage('assets/images/placeholder.png'),
                        image: breed.image != null &&
                                breed.image!.url.isNotEmpty
                            ? NetworkImage(breed.image!.url)
                            : const AssetImage('assets/images/placeholder.png')
                                as ImageProvider, // Si es nulo, muestra el placeholder
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset('assets/images/placeholder.png');
                        },
                      ),
                    ),
                  ),
                  title: Text(
                    breed.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryGreenColor),
                  ),
                  subtitle: Text(breed.origin),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, 'catDetail',
                        arguments: breed);
                  },
                );
              },
            ),
          );
        } else {
          return Container(
            color: AppColors.greyBackgroundColor,
            child: Center(
              child: Text('Failed to search breeds.',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[500])),
            ),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: AppColors.greyBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Find your cat',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500]),
            ),
            Text(
              'Discover the best breed for you.',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400]),
            )
          ],
        ),
      ),
    );
  }
}
