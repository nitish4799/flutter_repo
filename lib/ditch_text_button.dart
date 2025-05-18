import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';

class DitchTextButton extends StatelessWidget {
  const DitchTextButton({
    super.key,
    required this.onPressed,
    required this.label,
  });
  final void Function() onPressed;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: DitchText(text: label, fontSize: 15),
    );
  }
}
