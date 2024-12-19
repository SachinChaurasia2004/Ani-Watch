import 'package:ani_watch/search_anime_bloc/bloc/search_anime_bloc.dart';
import 'package:ani_watch/screens/webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAnimeScreen extends StatelessWidget {
  const SearchAnimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    void performSearch(String query) {
      if (query.isNotEmpty) {
        context.read<SearchAnimeBloc>().add(PerformSearch(query));
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Search Anime',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Search Anime',
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: performSearch,
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    performSearch(searchController.text.trim());
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchAnimeBloc, SearchAnimeState>(
              builder: (context, state) {
                if (state is SearchAnimeInitial) {
                  return const Center(
                    child: Text(
                      'Enter anime to search.',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                } else if (state is SearchAnimeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SearchAnimeLoaded) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: 2 / 3,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    itemCount: state.results.length,
                    itemBuilder: (context, index) {
                      final anime = state.results[index];
                      return Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WebViewScreen(
                                        initialUrl: anime.url ?? "",
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                  child: Image.network(
                                    anime.image ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    anime.title ?? 'No title available',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    anime.releaseDate ??
                                        'No release date available',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is SearchAnimeError) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
