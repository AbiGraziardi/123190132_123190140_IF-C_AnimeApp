class MangaModel {
  late int malId;
  late String url;
  late String imageUrl;
  late String title;
  late String titleEnglish;
  late String synopsis;
  late String status;
  late var volumes;
  late String rating;
  late var score;
  late var rank;
  late String published;
  late var chapters;
  late var favorites;

  MangaModel({
    this.malId = 0,
    this.url = '',
    this.imageUrl = '',
    this.title = '',
    this.titleEnglish = '',
    this.synopsis = '',
    this.status = '',
    this.volumes = 0,
    this.rating = '',
    this.score = 0,
    this.rank = 0,
    this.published = '',
    this.chapters = 0,
    this.favorites = 0,
  });

  factory MangaModel.fromJson(Map<String, dynamic> json) {

    return MangaModel(
      malId: json['mal_id'] ?? 0,
      url: json['url'] ?? '',
      imageUrl: json['image_url'] ?? '',
      title: json['title'] ?? '',
      titleEnglish: json['title_english'] ?? 'TBA',
      synopsis: json['synopsis'] ?? '',
      status: json['status'] ?? '',
      volumes: json['volumes'] ?? 0,
      rating: json['rating'] ?? '',
      score: json['score'] ?? 0,
      rank: json['rank'] ?? 0,
      published: json['published']['string'] ?? '',
      chapters: json['chapters'] ?? 0,
      favorites: json['favorites'] ?? 0,
    );
  }
}
