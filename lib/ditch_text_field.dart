import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';

class DitchTextField extends StatelessWidget {
  const DitchTextField({
    super.key,
    required this.label,
    this.onChangeHandler,
    required this.textEditingController,
    this.keyboardType,
    this.prefixText,
  });
  final String label;
  final void Function(String)? onChangeHandler;
  final TextEditingController textEditingController;
  final TextInputType? keyboardType;
  final String? prefixText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      onChanged: onChangeHandler,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixText: prefixText,
        label: DitchText(text: label, fontSize: 15),
      ),
    );
  }
}
