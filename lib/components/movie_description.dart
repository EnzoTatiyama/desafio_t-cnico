import 'package:flutter/material.dart';

import '../models/movie.dart';
import 'movie_detail_section.dart';

class MovieDescription extends StatelessWidget {
  const MovieDescription({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    String durationFormat(int min) {
      final duration = Duration(minutes: min);
      List<String> parts = duration.toString().split(':');
      String hour = parts[0];
      String minute = parts[1];
      return '${hour.padLeft(2, '0')} h ${minute.padLeft(2, '0')}m';
    }

    String dateFormat(String date) {
      final splittedDate = date.split('-');
      String day = splittedDate[2];
      String month = splittedDate[1];
      String year = splittedDate[0];
      return '${month}/${day}/${year}';
    }

    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MovieDetailSection(
                title: 'Original Title',
                body: movie.detail['title'],
              ),
              const SizedBox(height: 20),
              MovieDetailSection(
                title: 'Realesed Date',
                body: dateFormat(movie.detail['release_date']),
              ),
              const SizedBox(height: 20),
              MovieDetailSection(
                title: 'Vote Avarage',
                body: movie.detail['vote_average'].toString(),
                icon: Icons.star,
              ),
              const SizedBox(height: 20),
              MovieDetailSection(
                title: 'Overview',
                body: movie.detail['overview'],
              ),
              const SizedBox(height: 20),
              MovieDetailSection(
                title: 'Duration',
                body: durationFormat(movie.detail['runtime']),
                icon: Icons.timer_sharp,
              ),
              const SizedBox(height: 20),
            ],
          ),
        )
      ]),
    );
  }
}
