import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../models/movie_list.dart';
import './movie_grid_item.dart';

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
    final String errorText = provider.error;

    return hasError
        ? RefreshIndicator(
            onRefresh: () => _refreshPage(context),
            child: ListView(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.7),
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ]
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Center(
                        child: Image.asset(
                          'assets/images/image-error.jpg',
                          width: 300,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
                        child: Text(
                          errorText,
                          textScaleFactor: 2,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
