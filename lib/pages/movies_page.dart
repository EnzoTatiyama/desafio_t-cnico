import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/movie_list.dart';
import '../components/movie_grid.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<MovieList>(
      context,
      listen: false,
    ).loadMovies().then((value) {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/logo-tokenlab.png',
          height: 100,
          fit: BoxFit.fitWidth,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
              ),
            )
          : MovieGrid(),
    );
  }
}
