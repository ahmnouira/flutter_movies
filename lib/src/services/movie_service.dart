import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import "dart:io"; 


class MovieService {
  final String urlKey = "api_key=f9dba6179c34a9041a341f2c91214d0b";
  final String urlBase = "https://api.themoviedb.org/3/movie/";
  final String urlUpcoming = "/upcoming?";
  final String urlLangauge = "&langauge=en-US";

  Future<String> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey + urlLangauge;
    http.Response result  = await http.get(Uri.parse(upcoming)); 
    if(result.statusCode == HttpStatus.ok) {
      String responseBody = result.body; 
      return responseBody;
    } else {
      throw new ErrorDescription(result.statusCode.toString());
    }
  }
}
