import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/movie_header.dart';
import '../components/movie_description.dart';
import '../models/movie.dart';
import '../models/movie_list.dart';

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      body: CustomScrollView(
        slivers: [
          MovieHeader(),
          MovieDescription(movie: movie),
        ],
      ),
    );
  }
}
