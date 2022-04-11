import 'package:flutter/material.dart';

class TitleModify extends StatelessWidget {
  const TitleModify({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      alignment: Alignment.topLeft,
    );
  }
}
