import 'package:flutter/material.dart';
class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    this.gradientColor = const [
      Color.fromARGB(255, 96, 57, 165),
      Color.fromARGB(255, 73, 30, 142),
    ],
    required this.columnWidgets,
  });

  final List<Color> gradientColor;
  final List<Widget> columnWidgets;

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
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: columnWidgets,
        ),
      ),
    );
  }
}
