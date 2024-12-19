import 'package:ani_watch/data/repositories/anime_repository.dart';
import 'package:ani_watch/models/top_airing_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_airing_event.dart';
part 'top_airing_state.dart';

class TopAiringBloc extends Bloc<TopAiringEvent, TopAiringState> {
  final AnimeRepository animeRepository;
  TopAiringBloc(this.animeRepository) : super(TopAiringInitial()) {
    on<FetchTopAiring>((event, emit) async {
      emit(TopAiringLoading());
      try {
        final topAiring = await animeRepository.topAiring();
        emit(TopAiringLoaded(topAiring.results));
      } catch (e) {
        emit(TopAiringError(e.toString()));
      }
    });
  }
}
