import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/movie_list.dart';

class Error extends StatefulWidget {
  const Error({super.key});

  @override
  State<Error> createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  String errorText = "";

  @override
  void initState() {
    super.initState();
    errorText = Provider.of<MovieList>(
      context,
      listen: false,
    ).error;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ]),
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
    );
  }
}
