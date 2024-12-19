part of 'search_anime_bloc.dart';

@immutable
abstract class SearchAnimeEvent {}

class PerformSearch extends SearchAnimeEvent {
  final String query;

  PerformSearch(this.query);
}
