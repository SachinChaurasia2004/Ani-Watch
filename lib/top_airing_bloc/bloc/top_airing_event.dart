part of 'top_airing_bloc.dart';

@immutable
sealed class TopAiringEvent {}

class FetchTopAiring extends TopAiringEvent {}
