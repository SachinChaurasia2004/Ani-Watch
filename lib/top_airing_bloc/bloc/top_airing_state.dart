part of 'top_airing_bloc.dart';

@immutable
sealed class TopAiringState {}

final class TopAiringInitial extends TopAiringState {}

final class TopAiringLoading extends TopAiringState {}

final class TopAiringLoaded extends TopAiringState {
  final List<TopAiringResult> animes;

  TopAiringLoaded(this.animes);
}

class TopAiringError extends TopAiringState {
  final String message;

  TopAiringError(this.message);
}
