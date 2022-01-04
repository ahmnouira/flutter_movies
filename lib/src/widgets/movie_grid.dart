import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie.dart';
import 'package:flutter_movies/src/pages/movie_details.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;

  const MovieGrid({Key? key, required this.movies}) : super(key: key);

  Future _handleTap(BuildContext context, int index) async {
    MaterialPageRoute route =
        MaterialPageRoute(builder: (_) => MovieDetails(movie: movies[index]));
    await Navigator.push(context, route);
  }

  List<Widget> _renderGird() {
    List<Widget> widgets = [];
    String image;
    final String iconBase = 'https://image.tmdb.org/t/p/w500/';
    final String defaultImage =
        'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    for (var movie in movies) {
      if (movie.posterPath != null) {
        image = iconBase + movie.posterPath;
      } else {
        image = defaultImage;
      }

      Widget widget = Card(
          elevation: 8.0,
          child: InkWell(
              onTap: () => _handleTap,
              child: GridTile(
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                header: GridTileBar(
                  backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
                  title: Text(
                    movie.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )));

      widgets.add(widget);
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientaion) {
      return GridView.count(crossAxisCount: 2, children: _renderGird());
    });
  }
}
