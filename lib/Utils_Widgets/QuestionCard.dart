import 'package:flutter/material.dart';

import 'package:quizzapp2/Models/Question.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.q});
  final Question q;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: SizedBox(
                  width: 50, height: 50, child: Image.asset('images/Q.png')),
              title: Text(q.question),
              subtitle: Text(
                  "Correct answer is : ${q.rep == true ? 'Vrai' : 'Faux'}"),
            ),
          ],
        ),
      ),
    );
  }
}
