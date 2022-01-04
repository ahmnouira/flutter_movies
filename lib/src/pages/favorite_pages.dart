import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie.dart';
import 'package:flutter_movies/src/services/favorite_service.dart';
import 'package:flutter_movies/src/widgets/loading.dart';
import 'package:flutter_movies/src/widgets/movie_list.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late FavoriteService favoriteService;
  late bool loading;
  late List<Movie> movies;
  int moviesCount = 0;

  Future intialize() async {
    setState(() {
      loading = true;
    });
    movies = [];
    movies = await favoriteService.getFavorites();
    print(movies);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
      loading = false;
    });
  }

  @override
  void initState() {
    favoriteService = FavoriteService();
    intialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmall = false;

    if (MediaQuery.of(context).size.width < 600) {
      isSmall = true;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Favorite Movies',
          ),
          actions: [],
        ),
        body:
            loading ? Loading() : MovieList(movies: movies, isFavorite: true));
  }
}
