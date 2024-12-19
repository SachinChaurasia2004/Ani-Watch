part of 'recent_episodes_bloc.dart';

@immutable
sealed class RecentEpisodesState {}

final class RecentEpisodesInitial extends RecentEpisodesState {}

final class RecentEpisodesLoading extends RecentEpisodesState {}

final class RecentEpisodesLoaded extends RecentEpisodesState {
  final List<Result> episodes;

  RecentEpisodesLoaded(this.episodes);
}

class RecentEpisodesError extends RecentEpisodesState {
  final String message;

  RecentEpisodesError(this.message);
}
