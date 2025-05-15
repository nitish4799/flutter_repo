import 'package:flutter/material.dart';
import 'package:flutter_repo/quizscreens/question_screen.dart';
import 'package:flutter_repo/quizscreens/result_screen.dart';
import 'package:flutter_repo/quizscreens/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  late Widget activeScreen;

  @override
  void initState() {
    super.initState();
    activeScreen = StartScreen(onClickHandler: switchScreen);
  }

  List<int> answers = [];

  void addAnswers(int i) {
    answers.add(i);
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionScreen(
        onComplete: getResultScreen,
        answerQuestions: addAnswers,
      );
    });
  }

  void getResultScreen() {
    setState(() {
      activeScreen = ResultScreen(answers: answers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: activeScreen));
  }
}
