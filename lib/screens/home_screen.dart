import 'package:ani_watch/models/recent_episodes_model.dart';
import 'package:ani_watch/models/top_airing_model.dart';
import 'package:ani_watch/recent_episodes_bloc/bloc/recent_episodes_bloc.dart';
import 'package:ani_watch/screens/search_screen.dart';
import 'package:ani_watch/screens/webview_screen.dart';
import 'package:ani_watch/top_airing_bloc/bloc/top_airing_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RecentEpisodesBloc>().add(FetchRecentEpisodes());
    context.read<TopAiringBloc>().add(FetchTopAiring());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ani Watch',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<RecentEpisodesBloc, RecentEpisodesState>(
            listener: (context, state) {
              if (state is RecentEpisodesError) {
                _showErrorSnackbar(context, state.message);
              }
            },
          ),
          BlocListener<TopAiringBloc, TopAiringState>(
            listener: (context, state) {
              if (state is TopAiringError) {
                _showErrorSnackbar(context, state.message);
              }
            },
          ),
        ],
        child: BlocBuilder<RecentEpisodesBloc, RecentEpisodesState>(
          builder: (context, recentState) {
            return BlocBuilder<TopAiringBloc, TopAiringState>(
              builder: (context, topState) {
                if (recentState is RecentEpisodesLoading ||
                    topState is TopAiringLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (recentState is RecentEpisodesError &&
                    topState is TopAiringError) {
                  return const Center(
                    child: Text(
                      'Failed to load content. Please try again later.',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 10.0, bottom: 32.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SearchAnimeScreen(),
                            ),
                          );
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search Anime...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (recentState is RecentEpisodesLoaded)
                      _buildRecentEpisodesRow(recentState.episodes),
                    const SizedBox(
                      height: 10,
                    ),
                    if (topState is TopAiringLoaded)
                      _buildTopAiringRow(topState.animes),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildRecentEpisodesRow(List<Result> episodes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Recent Episodes',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              return _buildEpisodeCard(episodes[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopAiringRow(List<TopAiringResult> animes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Top Airing',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: animes.length,
            itemBuilder: (context, index) {
              return _buildTopAiringCard(animes[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEpisodeCard(Result episode) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          final episodeUrl = episode.url;
          if (episodeUrl == null || episodeUrl.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid URL'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(
                initialUrl: episodeUrl,
              ),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: 250,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    episode.image ?? '',
                    height: 250,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  episode.title ?? 'No Title',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTopAiringCard(TopAiringResult anime) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          final episodeUrl = anime.url;
          if (episodeUrl == null || episodeUrl.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Invalid URL'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebViewScreen(
                initialUrl: episodeUrl,
              ),
            ),
          );
        },
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: 250,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    anime.image ?? '',
                    height: 250,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  anime.title ?? 'No Title',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}
