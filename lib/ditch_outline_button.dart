import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';

class DitchOutlineButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Icon? icon;
  final VoidCallback onClickHandler;

  const DitchOutlineButton({
    super.key,
    required this.text,
    required this.fontSize,
    required this.onClickHandler,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onClickHandler,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: const BorderSide(color: Color.fromARGB(255, 60, 58, 58)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      icon: icon,
      label: DitchText(text: text, fontSize: fontSize),
    );
  }
}
