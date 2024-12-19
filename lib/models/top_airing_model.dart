class TopAiring {
  TopAiring({
    required this.currentPage,
    required this.hasNextPage,
    required this.results,
  });

  final int? currentPage;
  final bool? hasNextPage;
  final List<TopAiringResult> results;

  factory TopAiring.fromJson(Map<String, dynamic> json) {
    return TopAiring(
      currentPage: json["currentPage"],
      hasNextPage: json["hasNextPage"],
      results: json["results"] == null
          ? []
          : List<TopAiringResult>.from(
              json["results"]!.map((x) => TopAiringResult.fromJson(x))),
    );
  }
}

class TopAiringResult {
  TopAiringResult({
    required this.id,
    required this.title,
    required this.image,
    required this.url,
    required this.genres,
    required this.episodeId,
    required this.episodeNumber,
  });

  final String? id;
  final String? title;
  final String? image;
  final String? url;
  final List<String> genres;
  final String? episodeId;
  final int? episodeNumber;

  factory TopAiringResult.fromJson(Map<String, dynamic> json) {
    return TopAiringResult(
      id: json["id"],
      title: json["title"],
      image: json["image"],
      url: json["url"],
      genres: json["genres"] == null
          ? []
          : List<String>.from(json["genres"]!.map((x) => x)),
      episodeId: json["episodeId"],
      episodeNumber: json["episodeNumber"],
    );
  }
}
