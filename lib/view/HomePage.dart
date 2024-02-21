import 'package:flutter/material.dart';
import 'package:quizzer/data/Question.dart';
import 'package:quizzer/data/Quizz.dart';
import 'package:quizzer/view/QuizzPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Questions généré par chat gpt
    final List<Quizz> quizzes = [
      Quizz('Science', [
        Question('L\'eau bout à 100 degrés Celsius à niveau de la mer.', true),
        Question('Le symbole chimique pour le fer est "Fe".', true),
        Question(
            'Pluton est toujours considérée comme une planète dans notre système solaire.',
            false),
        Question('Les humains ont plus de 5 sens.', true),
        Question(
            'La lumière du soleil met environ 8 minutes et 20 secondes pour atteindre la Terre.',
            true),
      ]),
      Quizz('Culture Générale', [
        Question('Tokyo est la capitale du Japon.', true),
        Question(
            'Leonardo DiCaprio a gagné son premier Oscar pour son rôle dans Inception.',
            false),
        Question('La Mona Lisa a été peinte par Vincent van Gogh.', false),
        Question('Le café est originaire d\'Amérique.', false),
        Question('Le premier homme à marcher sur la lune était Neil Armstrong.',
            true),
      ]),
      Quizz('Histoire', [
        Question('La première guerre mondiale a commencé en 1914.', true),
        Question('Le mur de Berlin est tombé en 1989.', true),
        Question('Julius Caesar était un empereur romain.', false),
        Question('La révolution française a débuté en 1789.', true),
        Question(
            'Leonardo da Vinci est l\'auteur de "La dernière Cène".', true),
      ])
    ];
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5,
        ),
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            QuizzPage(quizz: quizzes[index])));
              },
              child: Center(
                child: Text(
                  quizzes[index].title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
