import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(context) {
    /* vIDEO #87. Making Content Scrollable with SingleChildScrollView
    Para establecer una altura fija para el resumen de preguntas, tenemos que 
    hacer un wrapped SizedBox en child: Column. Estamos usando SizedBox para 
    crear un caja con altura fija */
    return SizedBox(
      /* vIDEO #87. Making Content Scrollable with SingleChildScrollView
      Si la altura llegar a ser 300 px aparecerá un error de desbordamiento 
      de reprentación. Esto quiere decir que mi columna va más allá de los 
      límites establecidos. Para resolver esto usaremos un ScrollView, por eso 
      hacemos un wrapped WIDGET en child: Column*/
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          /* VIDEO #83 Accessing Map Values & Using "Type Casting": 
          Recordar que summaryData es un lista de mapas NO DE WIDGETS que es lo 
          que está esperando children. Por lo cual, debemos TRANSFORMAR esta 
          lista de objetos de mapa a una lista de widgets*/
          children: summaryData.map((data) {
            /* Aparece un error, que mi cosa iterable no se puede asignar a un 
            parámetro de tipo lista. Esto es debido a que MAP en realidad devuelve
            un objeto llamado iterable, QUE ES CASI LO MISMO QUE UNA LISTA pero no 
            del todo igual. Pero afortunadamente, un objeto iterable se puede 
            convertir a un LISTA, de la siguiente manera:*/
            return Row(
              children: [
                /* Como data['question'] es un valor de tipo objeto, Dart no sabe 
                si es un objeto de tipo int, string, etc. Por lo cual, si lo sumo 
                con 1, Dart no sabe si el objeto es un entero. Para solucionar 
                eso, realizamos un typecasting (encasillamiento). Se usan bastante
                en MAPS que almacenan tipos mixtos de valores. Por eso usamos
                "as int"*/
                Text(
                  ((data['question_index'] as int) + 1).toString(),
                ),
                Expanded(
                  /* VIDEO #85. Expanded To The Rescue:
                  Expanded es un Widget que permite a su hijo tomal el espacio 
                  disponible a lo largo del eje principal (Row or Column)*/
                  child: Column(
                    children: [
                      Text(
                        data['question'] as String,
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(data['correct_answer'] as String),
                      Text(data['user_answer'] as String),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
          /* Recordar que map asigna un valor a un nuevo valor */
        ),
      ),
    );
  }
}
