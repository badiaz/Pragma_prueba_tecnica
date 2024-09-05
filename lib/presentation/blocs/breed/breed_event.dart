part of 'breed_bloc.dart';

sealed class BreedEvent extends Equatable {
  const BreedEvent();

  @override
  List<Object> get props => [];
}

class FetchBreedsEvent extends BreedEvent {
  final int page;
  const FetchBreedsEvent({required this.page});
}

class SearchBreedsEvent extends BreedEvent {
  final String query;

  const SearchBreedsEvent(this.query);
}

class LoadMoreBreedsEvent extends BreedEvent {}

class ClearSearchResultsEvent extends BreedEvent {}
