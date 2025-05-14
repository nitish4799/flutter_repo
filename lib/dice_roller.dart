import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_repo/ditch_text.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

class _DiceRollerState extends State<DiceRoller> {
  var activeDiceNumber = 5;

  void rollDice() {
    setState(() {
      activeDiceNumber = randomizer.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset('assets/images/dice-$activeDiceNumber.png', width: 100),
        SizedBox(height: 20),
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            // padding: EdgeInsets.all(10),
            backgroundColor: const Color.fromARGB(255, 54, 50, 50),
          ),
          child: DitchText(text: 'Roll Dice', fontSize: 17),
        ),
      ],
    );
  }
}
