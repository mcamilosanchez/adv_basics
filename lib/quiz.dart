import 'package:adv_basics/data/questions.dart';
import 'package:adv_basics/questions_screen.dart';
import 'package:adv_basics/results_screen.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  // Ver videos 60 y 61
  /* Podemos almacenar Widgets en variables, es permitido ya que los Widgets son
  objetos, los cuales son valores normales en Dart */

  /* Vamos a realizar un Lifting State Up, vamos a pasar un puntero en 
  SwitchScreen a StartScreen*/

  final List<String> selectedAnswers = [];
  /* VIDEO #76: Passing Data via Functions Across Widgets: Se añade un nuevo 
  estado, es decir, una clase estado */

  var activeScreen = 'start-screen';
  /* Aparece un error en StartScreen(switchScreen), debido a que las lineas 
  21 y 29 suceden simultáneamente y por lo tanto aquí es demasiado pronto para 
  hacer referencia al method SwitchScreen ya que no está garantizado de que 
  exista todavía. Para solucionar esto, necesitamos crear otro método, iniState */

  /* Ahora, vamos a crear un método para navegar */
  void switchScreen() {
    setState(() {
      activeScreen = 'questions-screen';
    });
  }

  void restartQuiz() {
    setState(() {
      activeScreen = 'start-screen';
      selectedAnswers.length = 0;
    });
  }

  void chooseAnswer(String answer) {
    /* VIDEO #76 Passing Data via Functions Across Widgets:: Aquí se espera 
    obtener la repuesta seleccionada que debe ser tipo cadena */
    selectedAnswers
        .add(answer); //Añade un nuevo elemento a la lista sin reagsi.

    if (selectedAnswers.length == questions.length) {
      /* Cuando esta condición se cumple, significa que nos quedamos sin 
      preguntas. Entonces, vamos a cambiar a ResultsScreen. Para ello, debemos
      establecer de nuevo el estado (setState) para activar de nuevo el método 
      BUILD*/
      setState(() {
        /* Recordar que setState es una función anónima */
        //selectedAnswers.clear();
        activeScreen = 'results-screen';
        /* Esto no basta para que aparezca results-screen en la pantalla, tengo 
        que modificar también build*/
      });
    }
  }

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'questions-screen') {
      screenWidget = QuestionsSCreen(
        onSelectAnswer: chooseAnswer,
        /* Estamos reenviando la función chooseAnswer que se define en 
        QuizState a QuestionsScreem */
      );
    }

    if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
          chosenAnswers: selectedAnswers, restartQuiz: restartQuiz);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 13, 151),
                Color.fromARGB(255, 107, 15, 168)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          /* (62. Using Ternary Expressions & Comparison Operators)Vamos a usar 
          una expresión terniaria, permite comprobar una condición y luego dar 
          un valor si se cumple la condición y un valor alternativo si no se 
          cumple: */
          child: screenWidget,
        ),
      ),
    );
  }
}
