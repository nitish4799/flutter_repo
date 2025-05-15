import 'package:flutter/material.dart';
import 'package:flutter_repo/gradient_container.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/ditch_outline_button.dart';

class StartScreen extends StatelessWidget {
  final void Function() onClickHandler;
  const StartScreen({super.key, required this.onClickHandler});
  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      columnWidgets: [
        Image.asset(
          'assets/images/quiz-logo.png',
          width: 200,
          color: const Color.fromARGB(137, 255, 255, 255),
        ),
        SizedBox(height: 30),
        DitchText(text: 'Learn Flutter the fun way!', fontSize: 20),
        SizedBox(height: 30),
        DitchOutlineButton(
          text: 'Start Quiz',
          fontSize: 15,
          icon: Icon(Icons.arrow_right_alt),
          onClickHandler: onClickHandler,
        ),
      ],
    );
  }
}
