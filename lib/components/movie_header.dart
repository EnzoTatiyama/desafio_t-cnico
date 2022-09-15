import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieHeader extends StatelessWidget {
  const MovieHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return SliverAppBar(
      backgroundColor: const Color(0xff1f497d),
      expandedHeight: 600,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          movie.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: movie.id,
              child: Image.network(
                movie.posterUrl,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/default-placeholder.png',
                    fit: BoxFit.fitHeight,
                  );
                },
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0, 0.8),
                  end: Alignment(0, 0),
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0.6),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
