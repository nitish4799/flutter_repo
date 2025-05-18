import 'package:flutter/material.dart';

class DitchText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final String? fontFamily;
  final Color color;
  final TextAlign? align;
  final FontWeight? fontWeight;
  final IconData? icon;
  final double iconSize;
  final Color? iconColor;
  final bool iconAtStart;

  const DitchText({
    super.key,
    required this.text,
    this.fontSize = 28,
    this.color = Colors.white,
    this.fontFamily,
    this.align,
    this.fontWeight,
    this.icon,
    this.iconSize = 20,
    this.iconColor,
    this.iconAtStart = true,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = icon != null
        ? Icon(icon, size: iconSize, color: iconColor ?? color)
        : null;

    final textWidget = Text(
      text,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );

    return icon == null
        ? textWidget
        : Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: iconAtStart
                ? [iconWidget!, const SizedBox(width: 6), textWidget]
                : [textWidget, const SizedBox(width: 6), iconWidget!],
          );
  }
}
