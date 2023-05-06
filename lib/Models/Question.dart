// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Question {
  String question = '';
  bool rep = true;
  Question({
    required this.question,
    required this.rep,
  });

  Question copyWith({
    String? question,
    bool? rep,
  }) {
    return Question(
      question: question ?? this.question,
      rep: rep ?? this.rep,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'rep': rep,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      question: map['question'] as String,
      rep: map['rep'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Question(question: $question, rep: $rep)';

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.question == question && other.rep == rep;
  }

  @override
  int get hashCode => question.hashCode ^ rep.hashCode;
}
