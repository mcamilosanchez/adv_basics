import 'package:adv_basics/answer_button.dart';
import 'package:adv_basics/data/questions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSCreen extends StatefulWidget {
  const QuestionsSCreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;
  /* Es una variable que toma un argumento de tipo cadena y la llamamos 
  onSelectedAnswer. Es decir, es una función que se dispara en un determinado 
  evento. En otras palabras, esta es una función que no devuelve nada, pero toma
  un argumento posicional(answer) que es de tipo cadena*/

  @override
  State<QuestionsSCreen> createState() {
    return _QuestionsScreenState();
  }
}

/* VIDEO #76. Passing Data via Functions Across Widgets:
En QuestionsScreen tenemos un problema, que onSelectedScreen solamente está 
disponible en class widget QuestionsSCreen y lo NECESITAMOS en 
_QuestionsScreenState. Entonces la pregunta es: ¿cómo hacemos para que la 
propiedad onSelectAnswer que está en WidgetClass, esté dentro de StateClass? Ya 
que al final, lo que queremos es que onSelectAnswer se enjecute dentro de 
answerQuestion. Para realizar esto usamos una propiedad proporcionada por 
Flutter: widget */

class _QuestionsScreenState extends State<QuestionsSCreen> {
  /* VIDEO #73. Managing The Questions Index As State: Para cambiar las 
  preguntas, debemos asegurarnos de que el índice de preguntas questions[0] 
  cambie con el tiempo */
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    setState(() {
      widget.onSelectAnswer(selectedAnswer);
      /* En este código, se aplica la solución del problema del VIDEO #76 el 
      cual, se encuentra mencionado en el comentario grande: Usar la palabra 
      widget para pasar la propiedad onSelectAnswer de la clase WidgetClass a 
      StateClass. */

      /* Recordar que setState indica a Flutter que debe ejecutar el método 
      Build de nuevo. Esta es la FORMA CORRECTA DE ACTUALIZAR EL INDICE DE 
      PREGUNTAS ACTUAL */
      currentQuestionIndex++; //Increments the value by 1
    });
  }

  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity, //Significa que usará la mayor anchura posible
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, //Centra verticalmente
          /* crossAxisAlignment: los elementos dentro de la columna se estirarán 
          para ser tan anchos para llenar la columna */
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              textAlign: TextAlign.center,
              currentQuestion.text,
              style: GoogleFonts.lato(
                  //VIDEO #75 Adding Google Fonts
                  color: const Color.fromARGB(255, 201, 153, 251),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ...currentQuestion.getShuffleAnswers().map((answer) {
              /* Video #70. Mapping Lists & Using the Spread Operator :
              ¿Qué significa los tres puntos? currentQuestion.answers es una 
              lista o un iterable y Flutter no permite esto ya que Children está 
              esperando una LISTA DE WIDGETS. Es decir, dentro de Children 
              estamos creando una lista y dentro de currentQuestion estamos 
              creando otra lista, una lista anidada. CHILDREN SOLO QUIERE UNA 
              LISTA DE WIDGETS. Entonces, hacemos un SPREADING, repartir esta 
              lista o iterable, que es generado por map en un par de VALORES 
              INDIVIDUALES. Y ésto, se hace añadiendo TRES PUNTOS. */

              /* A diferencia de MAP, SHUFFLE cambia la lista original */
              return AnswerButton(
                answerText: answer,
                onTap: () {
                  /*ver VIDEO #76 MIN 10:25 Se usa una función anónima */
                  answerQuestion(answer);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
