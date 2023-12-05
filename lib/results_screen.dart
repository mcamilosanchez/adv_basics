import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/questions_summary/questions_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.restartQuiz});

  final List<String> chosenAnswers;

  final void Function() restartQuiz;

  List<Map<String, Object>> getSummaryData() {
    /* VIDEO #80. Introducing Maps & "for" Loops: This is a method, el cual 
    quiero que me devuelva una lista de valores. Recordar que MAP es una 
    estructura de datos que asigna valores a claves(keys). Además, Object es un 
    tipo de valor flexible que permite todo tipo de variables y esto permite 
    ALMACENAR DIFERENTES TIPOS DE VALORES en este Map */

    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        //Se usan las llaves para crear un mapa.
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        /* Recordar que era importante no barajar la lista de respuestas 
        original, ya que la primera(posición cero) respuesta es la correcta. */
        'user_answer': chosenAnswers[i]
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    /* VIDEO #86: Filtering & Analyzing Lists
    numCorrectQuestions es una variable donde va a comparar la cantidad de 
    preguntas que respondió el usuario con las correctas, Para eso, usamos 
    WHERE, es como realizar un filtrado. Si el valor de return es TRUE, es punto
    de datos debe mantenerse en la nueva lista filtrada o FALSE si debe 
    eliminarse. Por último, usamos LENGTH para que nos dé la cantidad de 
    elementos que se mantuvieron en esta lista filtrada*/
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
      /* Si estos dos valores son iguales, devolverá TRUE */
    }).length;

    return SizedBox(
      width: double.infinity, //Significa que usará la mayor anchura posible
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          /* Este widget column, ocupa todo el espacio de la pantalla */
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.lato(
                color: const Color.fromARGB(255, 255, 195, 255),
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            QuestionsSummary(summaryData),
            /* Recordar que getSummaryData() la estamos ejecutando como función 
            ya que QuestionsSummary NO QUIERE UNA FUNCION sino está esperando 
            una lista de MAPS */
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: restartQuiz,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.replay_outlined),
              label: const Text('Restart Quiz!'),
            )
          ],
        ),
      ),
    );
  }
}
