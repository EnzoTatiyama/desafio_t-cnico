import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../models/movie_list.dart';
import './movie_grid_item.dart';
import './error.dart';

class MovieGrid extends StatelessWidget {
  const MovieGrid({super.key});

  Future<void> _refreshPage(BuildContext context) {
    return Provider.of<MovieList>(context, listen: false).loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieList>(context);
    final List<Movie> loadedMovies = provider.movies;
    final bool hasError = provider.error.isNotEmpty;

    return hasError
        ? RefreshIndicator(
            onRefresh: () => _refreshPage(context),
            child: ListView(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.7),
              children: const [
                Error(),
              ],
            ),
          )
        : GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: loadedMovies.length,
            itemBuilder: (ctx, idx) {
              return MovieGridItem(movie: loadedMovies[idx]);
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                mainAxisExtent: 255),
          );
  }
}
