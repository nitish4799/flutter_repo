import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    this.gradientColor = const [
      Color.fromARGB(255, 96, 57, 165),
      Color.fromARGB(255, 73, 30, 142),
    ],
    this.columnWidgets,
    this.rowWidgets,
  });

  final List<Color> gradientColor;
  final List<Widget>? columnWidgets;
  final List<Widget>? rowWidgets;

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    Widget child;
    if (isPortrait && columnWidgets != null) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        children: columnWidgets!,
      );
    } else if (!isPortrait && rowWidgets != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: rowWidgets!,
      );
    } else {
      child = const SizedBox();
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
