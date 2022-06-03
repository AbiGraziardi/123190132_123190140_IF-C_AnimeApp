class HomeAnimeModel {
  late int malId;
  late String url;
  late String imageUrl;
  late String title;
  late String startDate;
  late var episodes;
  late var score;

  HomeAnimeModel({
    required this.malId,
    required this.url,
    required this.imageUrl,
    required this.title,
    required this.startDate,
    required this.episodes,
    required this.score,
  });

  factory HomeAnimeModel.fromJson(Map<String, dynamic> json) {
    return HomeAnimeModel(
      malId: json['mal_id'],
      url: json['url'],
      imageUrl: json['image_url'],
      title: json['title'],
      startDate: json['start_date'],
      episodes: json['episodes'],
      score: json['score'],
    );
  }
}
