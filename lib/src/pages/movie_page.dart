import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie.dart';
import 'package:flutter_movies/src/pages/favorite_pages.dart';
import 'package:flutter_movies/src/services/movie_service.dart';
import 'package:flutter_movies/src/widgets/loading.dart';
import 'package:flutter_movies/src/widgets/movie_list.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key, bool search = false}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  late String result;
  late List<Movie> movies;
  int moviesCount = 0;
  late MovieService movieService;

  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text("Movies");

  bool loading = true;

  void _onPress() {
    if (this.visibleIcon.icon == Icons.search) {
      setState(() {
        this.visibleIcon = Icon(Icons.cancel);
        this.searchBar = TextField(
          textInputAction: TextInputAction.search,
          cursorWidth: 2,
          cursorColor: Colors.blue,
          onSubmitted: (String text) {
            seach(text);
          },
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        );
      });
    } else {
      intialize();
      setState(() {
        this.visibleIcon = Icon(Icons.search);
        this.searchBar = Text("Movies");
      });
    }
  }

  Future<void> _navigateToFavorite(BuildContext context) async {
    MaterialPageRoute route = MaterialPageRoute(builder: (_) => FavoritePage());
    await Navigator.push(context, route);
  }

  Future seach(String text) async {
    setState(() {
      loading = true;
    });
    movies = await movieService.findMovies(text);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
      loading = false;
    });
  }

  Future intialize() async {
    setState(() {
      loading = true;
    });
    movies = [];
    movies = await movieService.getUpcoming();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
      loading = false;
    });
  }

  @override
  void initState() {
    movieService = MovieService();
    intialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: searchBar,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: InkWell(
                child: Icon(Icons.star),
                onTap: () => _navigateToFavorite,
              ),
            ),
            InkWell(
              child: visibleIcon,
              onTap: _onPress,
            )
          ],
        ),
        body: loading
            ? Loading()
            : movies.length == 0
                ? (Container(
                    margin: EdgeInsets.only(top: 32),
                    child: Text(
                      'Not Found',
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ))
                : MovieList(
                    movies: movies,
                    isFavorite: false,
                  ));
  }
}
