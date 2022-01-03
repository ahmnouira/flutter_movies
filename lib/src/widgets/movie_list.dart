import 'package:flutter/material.dart';
import 'package:flutter_movies/src/services/movie_service.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late String result;
  late MovieService movieService;

  @override
  void initState() {
    movieService = MovieService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    movieService.getUpcoming().then((value) {
      setState(() {
        result = value;
      });
    });

    return Text(result);
  }
}
