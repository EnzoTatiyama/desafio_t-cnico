import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';
import '../models/movie_detail.dart';
import '../models/movie_list.dart';
import 'movie_detail_section.dart';
import './error.dart';

class MovieDescription extends StatefulWidget {
  final movie;

  const MovieDescription({
    super.key,
    required this.movie,
  });

  @override
  State<MovieDescription> createState() => _MovieDescriptionState();
}

class _MovieDescriptionState extends State<MovieDescription> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<MovieList>(
      context,
      listen: false,
    ).loadDetailMovie(widget.movie.id).then((value) {
      setState(() => _isLoading = false);
    });
  }

  Future<void> _refreshPage(BuildContext context) {
    setState(() => _isLoading = true);
    return Provider.of<MovieList>(context, listen: false)
        .loadDetailMovie(widget.movie.id).then((value) {
          setState(() => _isLoading = false);
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieList>(context);
    final bool hasError = provider.error.isNotEmpty;
    final MovieDetail movieDetail = provider.moviesDetail;

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
        _isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                  ),
                ),
              )
            : hasError
                ? Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 40),
                  child: Column(
                    children: const [
                      Error(),
                    ],
                  ),
                )
                : Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
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
                          body: movieDetail.title,
                        ),
                        const SizedBox(height: 20),
                        MovieDetailSection(
                          title: 'Realesed Date',
                          body: dateFormat(movieDetail.releaseDate),
                        ),
                        const SizedBox(height: 20),
                        MovieDetailSection(
                          title: 'Vote Avarage',
                          body: movieDetail.voteAverage,
                          icon: Icons.star,
                        ),
                        const SizedBox(height: 20),
                        MovieDetailSection(
                          title: 'Overview',
                          body: movieDetail.overview,
                        ),
                        const SizedBox(height: 20),
                        MovieDetailSection(
                          title: 'Duration',
                          body: durationFormat(movieDetail.runtime),
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
