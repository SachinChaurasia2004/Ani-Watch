import 'package:ani_watch/data/repositories/anime_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/recent_episodes_model.dart';

part 'recent_episodes_event.dart';
part 'recent_episodes_state.dart';

class RecentEpisodesBloc
    extends Bloc<RecentEpisodesEvent, RecentEpisodesState> {
  final AnimeRepository animeRepository;
  RecentEpisodesBloc(this.animeRepository) : super(RecentEpisodesInitial()) {
    on<FetchRecentEpisodes>((event, emit) async {
      emit(RecentEpisodesLoading());
      try {
        final recentEpisodes = await animeRepository.recentEpisodes();
        emit(RecentEpisodesLoaded(recentEpisodes.results));
      } catch (e) {
        emit(RecentEpisodesError(e.toString()));
      }
    });
  }
}
