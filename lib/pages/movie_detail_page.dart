import 'package:flutter/material.dart';

import '../components/movie_header.dart';
import '../components/movie_description.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      body: CustomScrollView(
        slivers: [
          MovieHeader(),
          MovieDescription()
        ],
      ),
    );
  }
}
