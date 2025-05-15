import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';

class DitchElevatedButton extends StatelessWidget {
  final void Function() onClickHandler;
  final String label;
  final double? fontSize;

  const DitchElevatedButton({
    super.key,
    required this.onClickHandler,
    required this.label,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.85, // 70% of screen width
      child: ElevatedButton(
        onPressed: onClickHandler,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(96, 49, 48, 48),
        ),
        child: DitchText(text: label, fontSize: fontSize),
      ),
    );
  }
}
