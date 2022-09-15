import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../utils/constants.dart';
import './movie.dart';

class MovieList with ChangeNotifier {
  List<Movie> _movies = [];
  String error = '';

  List<Movie> get movies => [..._movies];

  Future<void> loadMovies() async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;

    if (!hasInternet) {
      error = Constants.ERROR_INTERNET;
      return;
    }

    final response = await http.get(
      Uri.parse(Constants.MOVIE_URL),
    );

    if (response.body == 'null') {
      error = '${response.statusCode} - ${Constants.ERROR_API}';
      return;
    }

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      await Future.forEach(data, (movieElement) async {
        final responseDetail = await http.get(
          Uri.parse('${Constants.MOVIE_URL}/${movieElement['id']}'),
        );

        if (responseDetail.body == 'null') return;
        Map<String, dynamic> movieDetail = jsonDecode(responseDetail.body);

        _movies.add(Movie(
            id: movieElement['id'],
            voteAverage: movieElement['vote_average'].toString(),
            title: movieElement['title'],
            posterUrl: movieElement['poster_url'],
            genres: movieElement['genres'],
            releaseDate: movieElement['release_date'],
            detail: movieDetail));
      });
      error = "";
    } else {
      error = '${response.statusCode} - ${Constants.ERROR_API}';
    }
    notifyListeners();
  }
}
