import 'package:adv_basics/questions_summary/questions_identifier.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(context) {
    final isCorrectAnswer =
        itemData['user_answer'] == itemData['correct_answer'];

    return Row(
      /*Este crossAxisAlignment hace que el índice de la pregunta esté arriba*/
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /* Como data['question'] es un valor de tipo objeto, Dart no sabe 
        si es un objeto de tipo int, string, etc. Por lo cual, si lo sumo 
        con 1, Dart no sabe si el objeto es un entero. Para solucionar 
        eso, realizamos un typecasting (encasillamiento). Se usan bastante
        en MAPS que almacenan tipos mixtos de valores. Por eso usamos
        "as int"*/
        QuestionsIdentifier(itemData['question_index'] as int, isCorrectAnswer),
        const SizedBox(width: 20),
        Expanded(
          /* VIDEO #85. Expanded To The Rescue:
          Expanded es un Widget que permite a su hijo tomar el espacio 
          disponible a lo largo del eje principal (Row or Column)*/
          child: Column(
            /*Este crossAxisAlignment hace que los elementos de la columna estén
             a la izquierda*/
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemData['question'] as String,
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                itemData['user_answer'] as String,
                style: const TextStyle(
                  color: Color.fromARGB(255, 202, 171, 252),
                ),
              ),
              Text(
                itemData['correct_answer'] as String,
                style: const TextStyle(
                  color: Color.fromARGB(255, 181, 254, 246),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
