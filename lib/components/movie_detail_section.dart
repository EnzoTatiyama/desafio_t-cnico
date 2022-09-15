import 'package:flutter/material.dart';

class MovieDetailSection extends StatelessWidget {
  final String title;
  final String body;
  final IconData? icon;

  const MovieDetailSection({
    super.key,
    required this.title,
    required this.body,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    bool hasIcon() {
      return this.icon != null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 62, 62, 62),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        hasIcon()
            ? Row(
                children: [
                  Icon(
                    icon,
                    color: const Color(0xff1f497d),
                  ),
                  const SizedBox(width: 5),
                  Flexible(
                    child: Text(
                      body,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 62, 62, 62),
                      ),
                    ),
                  ),
                ],
              )
            : Text(
                body,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 62, 62, 62),
                ),
              ),
      ],
    );
  }
}
