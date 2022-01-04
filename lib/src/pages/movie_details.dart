import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie.dart';

class MovieDetails extends StatelessWidget {
  final Movie movie;
  final String imgPath = 'https://image.tmdb.org/t/p/w500/';

  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String path;

    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 16),
          child: Column(
            children: <Widget>[
              Container(
                child: Image.network(path),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16, top: 32),
                child: Text(
                  movie.overview,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
