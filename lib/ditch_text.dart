import 'package:flutter/material.dart';

class DitchText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final String? fontFamily;
  final Color color;
  final TextAlign? align;
  final FontWeight? fontWeight;

  const DitchText({
    super.key,
    required this.text,
    this.fontSize = 28,
    this.color = Colors.white,
    this.fontFamily,
    this.align,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
