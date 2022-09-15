import 'package:flutter/material.dart';

class Movie with ChangeNotifier {
  final int id;
  final String voteAverage;
  final String title;
  final String posterUrl;
  final List<dynamic> genres;
  final String releaseDate;
  final Map<String, dynamic> detail;

  Movie({
    required this.id,
    required this.voteAverage,
    required this.title,
    required this.posterUrl,
    required this.genres,
    required this.releaseDate,
    required this.detail,
  });
}