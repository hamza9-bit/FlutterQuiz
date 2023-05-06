// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:quizzapp2/Models/Question.dart';

class Quiz {
  String quizName = "";
  String quizId = "";
  int currentQuestion = 0;
  dynamic questions = List.empty();
  dynamic players = List.empty();
  Quiz(
      {required this.quizName,
      required this.quizId,
      required this.questions,
      required this.players,
      required this.currentQuestion});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quizName': quizName,
      'quizId': quizId,
      'currentQuestion': currentQuestion,
      'questions': questions,
      'players': players,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      quizName: map['quizName'] as String,
      quizId: map['quizId'] as String,
      currentQuestion: map['currentQuestion'] as int,
      questions: map['questions'] as dynamic,
      players: map['players'] as dynamic,
    );
  }

  String toJson() => json.encode(toMap());

  factory Quiz.fromJson(String source) =>
      Quiz.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Quiz(quizName: $quizName, quizId: $quizId)';

  @override
  bool operator ==(covariant Quiz other) {
    if (identical(this, other)) return true;

    return other.quizName == quizName && other.quizId == quizId;
  }

  @override
  int get hashCode => quizName.hashCode ^ quizId.hashCode;
}
