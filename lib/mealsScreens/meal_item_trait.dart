import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 15, color: Colors.white),
        SizedBox(width: 6),
        DitchText(text: label, fontSize: 15,),
      ],
    );
  }
}
