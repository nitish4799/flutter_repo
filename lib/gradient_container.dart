import 'package:flutter/material.dart';
import 'package:flutter_repo/dice_roller.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    this.gradientColor = const [
      Color.fromARGB(255, 96, 57, 165),
      Color.fromARGB(255, 73, 30, 142),
    ],
  });

  final List<Color> gradientColor;

  @override
  Widget build(context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      // child: const Center(child: DitchText(text: 'Ditch Navigation')),
      child: Center(child: DiceRoller()),
    );
  }
}
