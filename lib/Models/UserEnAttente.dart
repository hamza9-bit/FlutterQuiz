// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserEnAttente {
  String id = '';
  String name = "";
  String quizName = '';
  bool accepted = false;
  int score = 0;
  bool refused = false;
  UserEnAttente({
    required this.id,
    required this.name,
    required this.quizName,
    required this.accepted,
    required this.score,
    required this.refused,
  });

  UserEnAttente copyWith({
    String? id,
    String? name,
    String? quizName,
    bool? accepted,
    int? score,
    bool? refused,
  }) {
    return UserEnAttente(
      id: id ?? this.id,
      name: name ?? this.name,
      quizName: quizName ?? this.quizName,
      accepted: accepted ?? this.accepted,
      score: score ?? this.score,
      refused: refused ?? this.refused,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quizName': quizName,
      'accepted': accepted,
      'score': score,
      'refused': refused,
    };
  }

  factory UserEnAttente.fromMap(Map<String, dynamic> map) {
    return UserEnAttente(
      id: map['id'] as String,
      name: map['name'] as String,
      quizName: map['quizName'] as String,
      accepted: map['accepted'] as bool,
      score: map['score'] as int,
      refused: map['refused'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEnAttente.fromJson(String source) =>
      UserEnAttente.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserEnAttente(id: $id, name: $name, quizName: $quizName, accepted: $accepted, score: $score, refused: $refused)';
  }

  @override
  bool operator ==(covariant UserEnAttente other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.quizName == quizName &&
        other.accepted == accepted &&
        other.score == score &&
        other.refused == refused;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        quizName.hashCode ^
        accepted.hashCode ^
        score.hashCode ^
        refused.hashCode;
  }
}
