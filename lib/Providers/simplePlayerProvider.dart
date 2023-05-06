import 'package:flutter/material.dart';

import 'package:quizzapp2/Models/UserEnAttente.dart';

class SimplePlayerProvider extends ChangeNotifier {
  UserEnAttente userEnAttente = UserEnAttente(
      id: "id",
      name: "name",
      quizName: "quizName",
      accepted: false,
      score: 0,
      refused: false);
/*   int score = 0;
  String userNickName = "nickName";
  String usertempAvatar = "images/avatars/1.png";
  String quizEnCours = '';

  int get userScore => score;
  String get userName => userNickName;
  String get userAvatar => usertempAvatar;
  String get QuizEnCours => quizEnCours; */

  UserEnAttente get theUserEnAttente => userEnAttente;
  String get currentQuiz => userEnAttente.quizName;
  void setScore(int qValue) {
    userEnAttente.score = qValue;
  }

  void setUser(UserEnAttente u) {
    userEnAttente = u;
  }

  void setQuizId(String sValue) {
    userEnAttente.quizName = sValue;
  }
}
