import 'package:flutter/material.dart';
import 'package:quizzapp2/Models/Question.dart';

class AdminProvider extends ChangeNotifier {
  String quizName = "name of the quiz";
  String quizId = "id of the quiz";
  List<Question> quizQuestion = List.empty(growable: true);
  bool adminLoged = false;

  List<Question> get QuizQuestions => quizQuestion;
  String get QuizName => quizName;
  String get QuizId => quizId;

  void addQuestion(Question q) async {
    quizQuestion.add(q);
  }

  void adminidLoging() {
    adminLoged = !adminLoged;
  }

  void saveNameQuiz(String name, String id) async {
    quizName = name;
    quizId = id;
  }
}
