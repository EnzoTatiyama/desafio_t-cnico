import 'package:desafio_estagio/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class MovieGridItem extends StatelessWidget {
  final Movie movie;

  const MovieGridItem({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.MOVIE_DETAILS,
          arguments: movie,
        );
      },
      child: GestureDetector(
        child: Hero(
          tag: movie,
          child: FadeInImage(
            placeholder:
                const AssetImage('assets/images/default-placeholder.png'),
            image: NetworkImage(movie.posterUrl),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/default-placeholder.png',
                fit: BoxFit.fitWidth,
              );
            },
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
