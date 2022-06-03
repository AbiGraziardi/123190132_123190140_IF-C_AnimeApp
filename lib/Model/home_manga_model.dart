class HomeMangaModel {
  late int malId;
  late String url;
  late String imageUrl;
  late String title;
  late String startDate;
  late var score;

  HomeMangaModel({
    required this.malId,
    required this.url,
    required this.imageUrl,
    required this.title,
    required this.startDate,
    required this.score,
  });

  factory HomeMangaModel.fromJson(Map<String, dynamic> json) {
    return HomeMangaModel(
      malId: json['mal_id'],
      url: json['url'],
      imageUrl: json['image_url'],
      title: json['title'],
      startDate: json['start_date'],
      score: json['score'],
    );
  }
}