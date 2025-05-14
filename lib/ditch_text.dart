import 'package:flutter/material.dart';

class DitchText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const DitchText({
    super.key,
    required this.text,
    this.fontSize = 28,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color, fontSize: fontSize),
    );
  }
}
