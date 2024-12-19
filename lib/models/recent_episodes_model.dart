class RecentEpisodes {
  RecentEpisodes({
    required this.currentPage,
    required this.hasNextPage,
    required this.results,
  });

  final int? currentPage;
  final bool? hasNextPage;
  final List<Result> results;

  factory RecentEpisodes.fromJson(Map<String, dynamic> json) {
    return RecentEpisodes(
      currentPage: json["currentPage"],
      hasNextPage: json["hasNextPage"],
      results: json["results"] == null
          ? []
          : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );
  }
}

class Result {
  Result({
    required this.id,
    required this.episodeId,
    required this.episodeNumber,
    required this.title,
    required this.image,
    required this.url,
  });

  final String? id;
  final String? episodeId;
  final int? episodeNumber;
  final String? title;
  final String? image;
  final String? url;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json["id"],
      episodeId: json["episodeId"],
      episodeNumber: json["episodeNumber"],
      title: json["title"],
      image: json["image"],
      url: json["url"],
    );
  }
}
