import 'package:ani_watch/data/repositories/anime_repository.dart';
import 'package:ani_watch/models/anime_search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_anime_event.dart';
part 'search_anime_state.dart';

class SearchAnimeBloc extends Bloc<SearchAnimeEvent, SearchAnimeState> {
  final AnimeRepository animeRepository;

  SearchAnimeBloc(this.animeRepository) : super(SearchAnimeInitial()) {
    on<PerformSearch>((event, emit) async {
      emit(SearchAnimeLoading());
      try {
        final results = await animeRepository.searchAnime(event.query);
        emit(SearchAnimeLoaded(results.results));
      } catch (error) {
        emit(SearchAnimeError(error.toString()));
      }
    });
  }
}
