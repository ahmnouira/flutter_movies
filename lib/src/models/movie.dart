class Movie {
  late int id;
  late String title;
  late double voteAverage;
  late String releaseDate;
  late String overview;
  late String posterPath;

  Movie(this.id, this.title, this.voteAverage, this.releaseDate, this.overview,
      this.posterPath);

  Movie.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.title = parsedJson['title'];
    this.voteAverage = parsedJson['vote_average'] * 1.0;
    this.releaseDate = parsedJson['release_date'];
    this.overview = parsedJson['overview'];
    this.posterPath = parsedJson['poster_path'];
  }
}
