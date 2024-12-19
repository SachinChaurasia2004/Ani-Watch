import 'package:ani_watch/data/providers/api_provider.dart';
import 'package:ani_watch/data/repositories/anime_repository.dart';
import 'package:ani_watch/recent_episodes_bloc/bloc/recent_episodes_bloc.dart';
import 'package:ani_watch/screens/home_screen.dart';
import 'package:ani_watch/search_anime_bloc/bloc/search_anime_bloc.dart';
import 'package:ani_watch/top_airing_bloc/bloc/top_airing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiProvider = ApiProvider();
    final animeRepository = AnimeRepository(apiProvider: apiProvider);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiProvider>(
          create: (_) => apiProvider,
        ),
        RepositoryProvider<AnimeRepository>(
          create: (_) => animeRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SearchAnimeBloc>(
            create: (context) =>
                SearchAnimeBloc(context.read<AnimeRepository>()),
          ),
          BlocProvider<RecentEpisodesBloc>(
            create: (context) =>
                RecentEpisodesBloc(context.read<AnimeRepository>()),
          ),
          BlocProvider<TopAiringBloc>(
            create: (context) => TopAiringBloc(context.read<AnimeRepository>()),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'AniWatch',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
