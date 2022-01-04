import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie.dart';
import 'package:flutter_movies/src/services/movie_service.dart';
import 'package:flutter_movies/src/widgets/loading.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key, bool search = false}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late String result;
  late List<Movie> movies;
  int moviesCount = 0;
  late MovieService movieService;

  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text("Movies");

  bool loading = true;

  _onPress() {
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
    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: <Widget>[IconButton(onPressed: _onPress, icon: visibleIcon)],
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
              : Container(
                  child: (ListView.builder(
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
                      itemCount: this.moviesCount)),
                ),
    );
  }
}
