import 'package:flutter/material.dart';

class KlinTitle extends StatelessWidget {
  const KlinTitle(
    this.text, {
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
