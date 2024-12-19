import 'package:ani_watch/data/providers/api_provider.dart';
import 'package:ani_watch/models/recent_episodes_model.dart';
import 'package:ani_watch/models/anime_search_model.dart';
import 'package:ani_watch/models/top_airing_model.dart';

class AnimeRepository {
  final ApiProvider apiProvider;

  AnimeRepository({required this.apiProvider});

  Future<AnimeSearch> searchAnime(String query) async {
    return await apiProvider.searchAnime(query);
  }

  Future<RecentEpisodes> recentEpisodes() async {
    return await apiProvider.recentEpisodes();
  }

  Future<TopAiring> topAiring() async {
    return await apiProvider.topAiring();
  }
}
