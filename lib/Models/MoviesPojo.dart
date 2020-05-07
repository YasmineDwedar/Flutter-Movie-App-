import 'genre.dart';

class MoviesPojo {
  String posterPath;
  int id;
  String originalTitle;
  List<int> genreIds;
//  List<dynamic> genres;
  double voteAverage;
  String overview;
  String releaseDate;

  MoviesPojo({
    this.posterPath,
    this.id,
    this.originalTitle,
    this.genreIds,
    this.voteAverage,
    this.overview,
    this.releaseDate,
//      this.genres
  });
  factory MoviesPojo.fromJson(Map<String, dynamic> json) => MoviesPojo(
        posterPath: json["poster_path"],
        id: json["id"],
        originalTitle: json["original_title"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        releaseDate: json["release_date"],
        //   genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "id": id,
        "original_title": originalTitle,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "vote_average": voteAverage,
        "overview": overview,
        "release_date": releaseDate,
      };
}
