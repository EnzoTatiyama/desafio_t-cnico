import 'package:flutter/material.dart';

class MovieDetail with ChangeNotifier  {
  final String id;
  final String title;
  final String releaseDate;
  final String voteAverage;
  final String overview;
  final int runtime; 
  // final List<dynamic> genres;

  MovieDetail({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.overview,
    required this.runtime,
  });

  void setMovieDetail(MovieDetail map) {}
}