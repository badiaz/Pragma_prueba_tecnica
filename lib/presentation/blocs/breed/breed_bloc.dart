import 'package:catbreeds/domain/entities/entities.dart';
import 'package:catbreeds/domain/use_cases/get_breeds_use_case.dart';
import 'package:catbreeds/domain/use_cases/filter_breeds_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'breed_event.dart';
part 'breed_state.dart';

class BreedBloc extends Bloc<BreedEvent, BreedState> {
  final IGetBreedsUseCase getBreedsUseCase;
  final IFilterBreedsUseCase filterBreedsUseCase;
  List<BreedEntity> _allBreeds = [];
  int currentPage = 0;

  BreedBloc({required this.getBreedsUseCase, required this.filterBreedsUseCase})
      : super(BreedInitial()) {
    on<FetchBreedsEvent>(_onFetchBreeds);
    on<SearchBreedsEvent>(_onSearchBreeds);
    on<LoadMoreBreedsEvent>(_onLoadMoreBreeds);
    on<ClearSearchResultsEvent>(_onClearSearchResults);
  }

  Future<void> _onFetchBreeds(
      FetchBreedsEvent event, Emitter<BreedState> emit) async {
    try {
      emit(BreedLoadingState());
      final breeds = await getBreedsUseCase.getBreeds(page: event.page);
      _allBreeds = breeds;
      emit(BreedLoadedState(breeds: breeds));
    } catch (e) {
      emit(const BreedErrorState('Failed to load breeds'));
    }
  }

  Future<void> _onLoadMoreBreeds(
      LoadMoreBreedsEvent event, Emitter<BreedState> emit) async {
    try {
      if (state is BreedLoadedState) {
        final currentState = state as BreedLoadedState;
        currentPage++;
        final moreBreeds = await getBreedsUseCase.getBreeds(page: currentPage);
        if (moreBreeds.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
        } else {
          _allBreeds = currentState.breeds + moreBreeds;
          emit(
            BreedLoadedState(
              breeds: currentState.breeds + moreBreeds,
              hasReachedMax: false,
            ),
          );
        }
      }
    } catch (e) {
      emit(const BreedErrorState('e'));
    }
  }

  Future<void> _onSearchBreeds(
      SearchBreedsEvent event, Emitter<BreedState> emit) async {
    try {
      emit(BreedLoadingState());
      final searchResults =
          await filterBreedsUseCase.searchBreeds(query: event.query);
      emit(BreedLoadedState(breeds: _allBreeds, searchResults: searchResults));
    } catch (e) {
      emit(const BreedErrorState('Failed to search breeds'));
    }
  }

  void _onClearSearchResults(
      ClearSearchResultsEvent event, Emitter<BreedState> emit) {
    currentPage = 0;
    emit(BreedInitial());
    add(FetchBreedsEvent(page: currentPage));
  }
}
