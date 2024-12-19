part of 'recent_episodes_bloc.dart';

@immutable
sealed class RecentEpisodesEvent {}

class FetchRecentEpisodes extends RecentEpisodesEvent {}
