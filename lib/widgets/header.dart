import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this.heading, {Key? key}) : super(key: key);
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      heading,
      style: const TextStyle(fontSize: 24),
    ),
  );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, {Key? key}) : super(key: key);
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    child: Text(
      content,
      style: const TextStyle(fontSize: 18),
    ),
  );
}
