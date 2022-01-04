import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final double width;

  Loading({this.width = 4});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        semanticsLabel: 'Waiting',
        strokeWidth: width,
      ),
    );
  }
}
