import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../utils/constants.dart';
import './movie.dart';
import './movie_detail.dart';

class MovieList with ChangeNotifier {
  List<Movie> _movies = [];
  List<MovieDetail> _moviesDetail = [];
  MovieDetail movieSelected = MovieDetail(id: 'id', title: 'title', releaseDate: 'releaseDate', voteAverage: 'voteAverage', overview: 'overview', runtime: 2);
  String _error = '';

  List<Movie> get movies => [..._movies];
  MovieDetail get moviesDetail => movieSelected;
  String get error => _error;

  set setMovieDetail(MovieDetail movieDetail) {
    movieSelected = movieDetail;
  }

  Future<void> loadMovies() async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;

    if (!hasInternet) {
      _error = Constants.ERROR_INTERNET;
      return;
    }

    if (_movies.isNotEmpty) return;
    
    final response = await http.get(
      Uri.parse(Constants.MOVIE_URL),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      await Future.forEach(data, (movieElement) async {
        _movies.add(Movie(
          id: movieElement['id'],
          voteAverage: movieElement['vote_average'].toString(),
          title: movieElement['title'],
          posterUrl: movieElement['poster_url'],
          genres: movieElement['genres'],
          releaseDate: movieElement['release_date'],
        ));
      });

      _error = '';
    } else {
      _error = '${response.statusCode} - ${Constants.ERROR_API}';
    }
    notifyListeners();
  }

  Future<void> loadDetailMovie(int movieId) async {
    bool hasInternet = await InternetConnectionChecker().hasConnection;

    if (!hasInternet) {
      _error = Constants.ERROR_INTERNET;
      return;
    }

    for (var map in _moviesDetail) {
      if (map.id == movieId.toString()) {
        movieSelected.setMovieDetail(map);
        notifyListeners();
        return;
      }
    }

    final response = await http.get(
      Uri.parse('${Constants.MOVIE_URL}/${movieId}'),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      movieSelected = MovieDetail(
        id: data['id'].toString(),
        title: data['title'],
        releaseDate: data['release_date'],
        voteAverage: data['vote_average'].toString(),
        overview: data['overview'],
        runtime: data['runtime'],
      );
      _moviesDetail.add(movieSelected);
      _error = '';
    } else {
      _error = '${response.statusCode} - ${Constants.ERROR_API}';
    }
    notifyListeners();
  }
}
