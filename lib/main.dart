import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:desafio_estagio/utils/app_routes.dart';
import './pages/movies_page.dart';
import './pages/movie_detail_page.dart';
import './models/movie_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieList(),
      child: MaterialApp(
        title: 'Desafio estágio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
        ),
        routes: {
          AppRoutes.HOME: (ctx) => MoviesPage(),
          AppRoutes.MOVIE_DETAILS: (ctx) => MovieDetailPage(),
        },
      ),
    );
  }
}
