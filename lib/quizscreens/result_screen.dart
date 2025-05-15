import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/data/questions.dart';
import 'package:flutter_repo/gradient_container.dart';

class ResultScreen extends StatelessWidget {
  final List<int> answers;
  const ResultScreen({super.key, required this.answers});

  @override
  Widget build(BuildContext context) {
    final correctAnswers = answers.where((answer) => answer != 0).length;

    return GradientContainer(
      columnWidgets: [
        DitchText(
          text:
              'You answered $correctAnswers out of ${answers.length} questions correctly!',
          fontSize: 17,
        ),
        const SizedBox(height: 20),
        ...questions.asMap().entries.map((entry) {
          final index = entry.key + 1;
          final question = entry.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color:
                        answers[entry.key] == 0
                            ? Colors.blueAccent
                            : const Color.fromARGB(255, 220, 41, 113),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: DitchText(text: '$index', fontSize: 14),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DitchText(
                        text: question.text,
                        fontSize: 15,
                        align: TextAlign.left,
                        fontWeight: FontWeight.bold,
                      ),
                      DitchText(
                        text: question.answers[answers[entry.key]],
                        fontSize: 10,
                        align: TextAlign.left,
                        color: const Color.fromARGB(255, 201, 84, 131),
                      ),
                      DitchText(
                        text: question.answers[0],
                        fontSize: 10,
                        align: TextAlign.left,
                        color: const Color.fromARGB(255, 106, 141, 202),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
