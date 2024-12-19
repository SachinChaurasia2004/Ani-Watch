class AnimeSearch {
  AnimeSearch({
    required this.currentPage,
    required this.hasNextPage,
    required this.results,
  });

  final int? currentPage;
  final bool? hasNextPage;
  final List<Result> results;

  factory AnimeSearch.fromJson(Map<String, dynamic> json) {
    return AnimeSearch(
      currentPage: json["currentPage"] is int
          ? json["currentPage"]
          : int.tryParse(
              json["currentPage"] ?? "0"), // Handle string to int conversion
      hasNextPage: json["hasNextPage"] ?? false,
      results: json["results"] == null
          ? []
          : List<Result>.from(
              json["results"]!.map((x) => Result.fromJson(x)),
            ),
    );
  }
}

class Result {
  Result({
    required this.id,
    required this.title,
    required this.url,
    required this.image,
    required this.releaseDate,
    required this.subOrDub,
  });

  final String? id;
  final String? title;
  final String? url;
  final String? image;
  final String? releaseDate;
  final String? subOrDub;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      id: json["id"],
      title: json["title"],
      url: json["url"],
      image: json["image"],
      releaseDate: json["releaseDate"],
      subOrDub: json["subOrDub"],
    );
  }
}
