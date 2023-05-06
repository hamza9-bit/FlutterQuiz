import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizzapp2/Models/Question.dart';
import 'package:quizzapp2/Models/QuizModel.dart';
import 'package:quizzapp2/Models/UserEnAttente.dart';

class QuizServices {
  final CollectionReference quizRef =
      FirebaseFirestore.instance.collection('quiz');
  final CollectionReference userEnAttente =
      FirebaseFirestore.instance.collection("usersEnAttente");

  static String generateRandomId() {
    String randomString = '';
    Random random = Random();

    for (int i = 0; i < 8; i++) {
      randomString += random.nextInt(10).toString();
    }
    return randomString;
  }

  Future<bool> verifQuizExists(String quizId) async {
    bool ok = false;
    await quizRef.doc(quizId).get().then((doc) {
      ok = doc.exists;
    });
    return ok;
  }

  saveMyScore(
    String quizId,
    UserEnAttente u,
  ) {
    int tempScore = u.score;
    u.accepted = true;
    u.score = 0;

    quizRef.doc(quizId).update({
      "players": FieldValue.arrayRemove([u.toMap()])
    });
    u.score = tempScore;
    quizRef.doc(quizId).update({
      "players": FieldValue.arrayUnion([u.toMap()])
    });
  }

  Future<List<Quiz>> getAllSavedQuiz() async {
    return await quizRef.get().then((value) {
      return value.docs.map((e) {
        var res = e.data() as Map<String, dynamic>;
        return Quiz.fromMap(res);
      }).toList();
    });
  }

  Future<List<Question>> getQuestionsOfQuiz(String quizId) async {
    return await quizRef.doc(quizId).get().then((value) {
      var res = value.data() as Map<String, dynamic>;
      var listQes = res["questions"] as List<dynamic>;
      return listQes.map((e) => Question.fromMap(e)).toList();
    });
  }

  Stream<int> guardQuiz(String id) {
    return quizRef.doc(id).snapshots().map((DocumentSnapshot documentSnapshot) {
      var res = documentSnapshot.data() as Map<String, dynamic>;
      return res['currentQuestion'] as int;
    });
  }

  Future<List<dynamic>> getUsersEnAttenteForQuiz(String quizId) async {
    final QuerySnapshot snapshot = await userEnAttente
        .where('quizName', isEqualTo: quizId)
        .where('accepted', isEqualTo: false)
        .get();

    final List<QueryDocumentSnapshot> documents = snapshot.docs;

    return documents.map((e) => e.data()).toList();
  }

  RefuseUser(String userId) {
    userEnAttente.doc(userId).update({"refused": true});
    Future.delayed((Duration(seconds: 1))).then((value) {
      userEnAttente.doc(userId).delete();
    });
  }

  Future<dynamic> login(String userName, String password) async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("Admins")
          .where('adminUserName', isEqualTo: userName.toString())
          .where('adminPassword', isEqualTo: password.toString())
          .get();

      if (snapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Stream<List<dynamic>> getPlayersInQuiz(String quizId) {
    return quizRef
        .doc(quizId)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      var res = documentSnapshot.data() as Map<String, dynamic>;
      return res['players'] as List<dynamic>;
    });
  }

  startQuiz(String quizId) {
    quizRef.doc(quizId).update({"currentQuestion": 0});
  }

  addUserToQuiz(UserEnAttente user) {
    user.accepted = true;
    quizRef.doc(user.quizName).update({
      "players": FieldValue.arrayUnion([user.toMap()])
    });
    userEnAttente.doc(user.id).update({"accepted": true});
  }

  nextQuestion(String idQuiz, int old) {
    int newVal = old + 1;

    quizRef.doc(idQuiz).update({"currentQuestion": newVal});
  }

  Future<dynamic> getQuizScore(String idQuiz) {
    return quizRef.doc(idQuiz).get().then((value) {
      print(value.data());
      var a = value.data() as Map<String, dynamic>;

      return a;
    }).catchError((error) {
      throw error();
    });
  }

  Future<void> addNewQuiz(Quiz quiz) async {
    quiz.currentQuestion = -1;
    // creating the quiz json
    print(quiz.toMap());

    quizRef.doc(quiz.quizId).set(quiz.toMap());
  }
}
