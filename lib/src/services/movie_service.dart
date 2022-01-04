import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_movies/src/models/movie.dart';
import 'package:http/http.dart' as http;
import "dart:io";

class MovieService {
  final String urlKey = "api_key=f9dba6179c34a9041a341f2c91214d0b";
  final String urlBase = "https://api.themoviedb.org/3/movie/";
  final String urlUpcoming = "/upcoming?";
  final String urlLangauge = "&langauge=en-US";

  Future<List<Movie>> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLangauge;
    http.Response result = await http.get(Uri.parse(upcoming));
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      print("jsonReponse" + jsonResponse);
      final movieMap = jsonResponse['results'];
      print(movieMap is Map<String, dynamic>);
      List<Movie> movies = movieMap.map((id) => Movie.fromJson(id));
      return movies;
    } else {
      throw new ErrorDescription(result.statusCode.toString());
    }
  }
}
