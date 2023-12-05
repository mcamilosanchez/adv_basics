class QuizQuestion {
  const QuizQuestion(this.text, this.answers);

  final String text;
  final List<String> answers;

  /* VIDEO #72. Mutating Values in Memory */

  List<String> getShuffleAnswers() {
    /* Recordar que FINAL garantiza que no puedes reasignar la variable */
    final answersShuffle = List.of(answers);
    answersShuffle.shuffle();
    /* List.of crea una nueva lista basada en otra lista, copia una lista 
    existente. Luego, por medio de Shuffle, se barajea dicha lista */
    return answersShuffle;
  }
}
