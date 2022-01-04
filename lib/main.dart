import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies/src/pages/home.dart';

void main() => runApp(Movies());

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Home(),
    );
  }
}
