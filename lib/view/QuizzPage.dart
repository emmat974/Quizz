import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizzer/data/Question.dart';
import 'package:quizzer/data/Quizz.dart';
import 'package:quizzer/view/HomePage.dart';

class QuizzPage extends StatefulWidget {
  const QuizzPage({super.key, required this.quizz});
  final Quizz quizz;
  @override
  State<QuizzPage> createState() => _QuizzPageState();
}

class _QuizzPageState extends State<QuizzPage> {
  int questionIndex = 0;
  late List<Question> questions;
  int score = 0;
  List<Widget> scoreKeeper = [];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    questions = widget.quizz.questions;
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void verifQuestion(bool responseUser) {
    timer?.cancel();
    bool responseCorrect = questions[questionIndex].response;

    setState(() {
      if (responseUser == responseCorrect) {
        score++;
        scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      } else {
        scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      }

      nextQuestion();
    });
  }

  void resetQuizz() {
    setState(() {
      questionIndex = 0;
      score = 0;
      scoreKeeper = [];
      startTimer();
    });
  }

  void showScoreDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Fin du Quizz"),
            content: Text("Votre score est de $score/${questions.length}"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetQuizz();
                  },
                  child: const Text("Rejouer")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: const Text("Retourner à l'accueil"))
            ],
          );
        });
  }

  void startTimer() {
    const timeLimit = Duration(seconds: 5);
    timer?.cancel();
    timer = Timer(timeLimit, handleTimeout);
  }

  void handleTimeout() {
    setState(() {
      scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (questionIndex < questions.length - 1) {
      questionIndex++;
      startTimer();
    } else {
      showScoreDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: questionQuizz(
                          question: questions[questionIndex].texte)),
                ),
                Expanded(
                  child: buttonQuizz(
                      onPressed: () => verifQuestion(true),
                      text: "Vrai",
                      color: Colors.green),
                ),
                Expanded(
                  child: buttonQuizz(
                      onPressed: () => verifQuestion(false),
                      text: "Faux",
                      color: Colors.red),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: scoreKeeper,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonQuizz(
      {required VoidCallback onPressed,
      required String text,
      required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          textStyle: const TextStyle(fontSize: 25, color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  Widget questionQuizz({required String question}) {
    return Container(
      child: Center(
        child: Text(
          question,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
