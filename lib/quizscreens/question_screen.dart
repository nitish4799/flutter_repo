import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_elevated_button.dart';
import 'package:flutter_repo/ditch_text.dart';
import 'package:flutter_repo/gradient_container.dart';
import 'package:flutter_repo/data/questions.dart';
// import 'package:';

// const List<int> questions = [1, 2, 3];
const List<int> answers = [0, 3, 2];

class QuestionScreen extends StatefulWidget {
  final VoidCallback onComplete;
  final Function(int) answerQuestions;
  const QuestionScreen({
    super.key,
    required this.onComplete,
    required this.answerQuestions,
  });
  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;
  void saveAnswer(int selectedAnswerIndex) {
    widget.answerQuestions(selectedAnswerIndex);

    if (currentQuestionIndex == questions.length - 1) {
      widget.onComplete();
    } else {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final originalAnswers = questions[currentQuestionIndex].answers;
    final indexedAnswers =
        originalAnswers
            .asMap()
            .entries
            .map((entry) => MapEntry(entry.key, entry.value))
            .toList();
    final shuffledAnswers = [...indexedAnswers]..shuffle();
    return GradientContainer(
      columnWidgets: [
        DitchText(text: questions[currentQuestionIndex].text, fontSize: 20),
        ...shuffledAnswers.map(
          (entry) => DitchElevatedButton(
            onClickHandler: () => saveAnswer(entry.key),
            label: entry.value,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
