part of 'breed_bloc.dart';

abstract class BreedState extends Equatable {
  const BreedState();

  @override
  List<Object?> get props => [];
}

final class BreedInitial extends BreedState {}

class BreedInitialState extends BreedState {}

class BreedLoadingState extends BreedState {}

class BreedLoadedState extends BreedState {
  final List<BreedEntity> breeds;
  final List<BreedEntity>? searchResults;
  final bool hasReachedMax;
  const BreedLoadedState(
      {this.breeds = const [],
      this.searchResults = const [],
      this.hasReachedMax = false});

  BreedLoadedState copyWith({
    List<BreedEntity>? breeds,
    List<BreedEntity>? searchResults,
    bool? hasReachedMax,
  }) =>
      BreedLoadedState(
          breeds: breeds ?? this.breeds,
          searchResults: searchResults,
          hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  @override
  List<Object?> get props => [breeds, searchResults, hasReachedMax];
}

class BreedErrorState extends BreedState {
  final String message;
  const BreedErrorState(this.message);
  @override
  List<Object> get props => [message];
}
