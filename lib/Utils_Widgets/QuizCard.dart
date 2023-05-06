import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quizzapp2/Models/QuizModel.dart';

import '../Providers/adminProvider.dart';

import '../MainScreens/listUsersEnattenteAdmin.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quiz});
  final Quiz quiz;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                child: Row(
                  children: [
                    const Text(
                      "code: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      quiz.quizId,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              subtitle: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                child: Row(
                  children: [
                    const Text(
                      "name: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      quiz.quizName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              trailing: ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                style:
                    ElevatedButton.styleFrom(minimumSize: const Size(80, 35)),
                label: const Text("Play", style: TextStyle(fontSize: 15)),
                onPressed: () {
                  Provider.of<AdminProvider>(context, listen: false).quizName =
                      quiz.quizId;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UsersEnAttenteInAdmin(
                          QuizId: quiz.quizId,
                        ),
                      ));
                  /*  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayQuiz(
                                idQuiz: quiz.quizId,
                              )),
                      (route) => false); */
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
