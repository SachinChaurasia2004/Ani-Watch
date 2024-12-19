part of 'search_anime_bloc.dart';

@immutable
abstract class SearchAnimeState {}

class SearchAnimeInitial extends SearchAnimeState {}

class SearchAnimeLoading extends SearchAnimeState {}

class SearchAnimeLoaded extends SearchAnimeState {
  final List<Result> results;

  SearchAnimeLoaded(this.results);
}

class SearchAnimeError extends SearchAnimeState {
  final String message;

  SearchAnimeError(this.message);
}
