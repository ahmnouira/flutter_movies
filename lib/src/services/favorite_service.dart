import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_movies/src/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  Future<bool> addToFavorites(Movie movie) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString(movie.id.toString());
    if (id == '') {
      return false;
    }
    return await preferences.setString(
        movie.id.toString(), json.encode(movie.toJson()));
  }

  Future<bool> removeFormFavorites(Movie movie) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString(movie.id.toString());
    if (id == '') {
      return false;
    }
    return await preferences.remove(movie.id.toString());
  }

  Future<List<Movie>> getFavorites() async {
    // retuens the favorite movies or an empty list
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    List<Movie> favMovies = [];
    Set<String> keys = preferences.getKeys();
    if (keys.isEmpty) {
      return favMovies;
    }
    for (int i = 0; i < keys.length; i++) {
      String key = keys.elementAt(i).toString();
      String value = preferences.get(key).toString();
      dynamic json = jsonDecode(value);
      Movie movie = Movie(json['id'], json['title'], json['voteAverage'],
          json['releaseDate'], json['overview'], json['posterPath']);
      favMovies.add(movie);
    }
    return favMovies;
  }
}
