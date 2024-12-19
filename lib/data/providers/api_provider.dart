import 'dart:convert';
import 'dart:io';
import 'package:ani_watch/models/anime_search_model.dart';
import 'package:ani_watch/models/recent_episodes_model.dart';
import 'package:ani_watch/models/top_airing_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<AnimeSearch> searchAnime(String anime) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://anime-rose-pi.vercel.app/anime/gogoanime/$anime?page=0'),
      );

      if (response.statusCode == 200) {
        return AnimeSearch.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw HttpException(
            'Failed to load Anime. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<RecentEpisodes> recentEpisodes() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://anime-rose-pi.vercel.app/anime/gogoanime/recent-episodes'),
      );

      if (response.statusCode == 200) {
        return RecentEpisodes.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw HttpException(
            'Failed to load Anime. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<TopAiring> topAiring() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://anime-rose-pi.vercel.app/anime/gogoanime/top-airing'),
      );

      if (response.statusCode == 200) {
        return TopAiring.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw HttpException(
            'Failed to load Anime. Status code: ${response.statusCode}');
      }
    } on SocketException {
      throw Exception('No Internet connection');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
