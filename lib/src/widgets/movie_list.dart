import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie.dart';
import 'package:flutter_movies/src/pages/favorite_pages.dart';
import 'package:flutter_movies/src/pages/movie_details.dart';
import 'package:flutter_movies/src/services/favorite_service.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final bool isFavorite;

  MovieList({required this.movies, this.isFavorite = false});

  final FavoriteService favoriteService = FavoriteService();

  Future _handleTap(BuildContext context, int index) async {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (_) => MovieDetails(movie: movies[index]));
    await Navigator.push(context, route);
  }

  Future _handlePress(Movie movie, BuildContext context) async {
    if (isFavorite) {
      final result = await favoriteService.removeFormFavorites(movie);
      print(result);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FavoritePage()));
      // return {"action": "delete", "result": result};
    } else {
      final result = await favoriteService.addToFavorites(movie);
      print(result);

      // return {"action": "add", "result": result};
    }
  }

  @override
  Widget build(BuildContext context) {
    final moviesCount = movies.length;
    NetworkImage image;
    final String iconBase = 'https://image.tmdb.org/t/p/w92/';
    final String defaultImage =
        'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

    return (Container(
        // height: MediaQuery.of(context).size.height / 1.4, // 60%
        child: ListView.builder(
            itemBuilder: (BuildContext context, int position) {
              final movie = movies[position];
              if (movie.posterPath != null) {
                image = NetworkImage(iconBase + movie.posterPath);
              } else {
                image = NetworkImage(defaultImage);
              }
              return (Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  onTap: () => _handleTap(context, position),
                  trailing: IconButton(
                      onPressed: () {
                        _handlePress(movie, context);
                      },
                      tooltip: (isFavorite)
                          ? "Remove from favorites"
                          : "Add to favorites",
                      icon: Icon(Icons.star),
                      color: isFavorite ? Colors.amber : Colors.grey),
                  leading: CircleAvatar(
                    backgroundImage: image,
                    backgroundColor: Colors.grey,
                  ),
                  title: Text(movie.title),
                  subtitle: Text('Released: ' +
                      movie.releaseDate +
                      ' - Vote: ' +
                      movie.voteAverage.toString()),
                ),
              ));
            },
            itemCount: moviesCount)));
  }
}
