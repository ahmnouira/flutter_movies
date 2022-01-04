import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_movies/src/models/movie.dart';
import 'package:http/http.dart' as http;
import "dart:io";

class MovieService {
  final String urlKey = "api_key=f9dba6179c34a9041a341f2c91214d0b";
  final String urlBase = "https://api.themoviedb.org/3";
  final String urlMovie = "/movie";
  final String urlUpcoming = "/upcoming?";
  final String urlLangauge = "&langauge=en-US";

  final String urlSearchBase =
      'https://api.themoviedb.org/3/search/movie?api_key=f9dba6179c34a9041a341f2c91214d0b&query=';

  Future<List<Movie>> getUpcoming() async {
    final String upcoming =
        urlBase + urlMovie + urlUpcoming + urlKey + urlLangauge;
    http.Response result = await http.get(Uri.parse(upcoming));
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = await json.decode(result.body);
      final List<dynamic> movieMap = jsonResponse['results'];
      List<Movie> movies = movieMap.map((id) => Movie.fromJson(id)).toList();
      return movies;
    } else {
      throw new ErrorDescription(result.statusCode.toString());
    }
  }

  Future<List<Movie>> findMovies(String title) async {
    final String query = urlSearchBase + title;
    http.Response result = await http.get(Uri.parse(query));
    if (result.statusCode == HttpStatus.ok) {
      final jsonRespone = json.decode(result.body);
      final List<dynamic> movieMap = jsonRespone['results'];
      List<Movie> movies = movieMap.map((id) => Movie.fromJson(id)).toList();
      return movies;
    } else {
      throw new ErrorDescription(result.statusCode.toString());
    }
  }
}
