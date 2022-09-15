import 'package:flutter/material.dart';

import '../utils/app_routes.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage('https://image.tmdb.org/t/p/w200/rPdtLWNsZmAtoZl9PK7S2wE3qiS.jpg'),
      ),
      title: Text('The Godfather'),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              color: Theme.of(context).primaryColor,
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.MOVIE_DETAILS,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}