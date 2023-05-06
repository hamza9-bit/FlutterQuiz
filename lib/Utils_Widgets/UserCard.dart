import 'package:flutter/material.dart';

import '../Models/UserEnAttente.dart';
import '../Providers/Services/QuizServices.dart';

class UserEnAttenteCard extends StatefulWidget {
  const UserEnAttenteCard({super.key, required this.user});
  final UserEnAttente user;

  @override
  State<UserEnAttenteCard> createState() => _UserEnAttenteCardState();
}

class _UserEnAttenteCardState extends State<UserEnAttenteCard> {
  String rep = "not yet";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.user.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 20)),
              ),
              rep == "not yet"
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                              child: const Text("Accept"),
                              onPressed: () {
                                // add the user the wanted quiz
                                QuizServices().addUserToQuiz(widget.user);
                                rep = "accepted";
                                setState(() {});
                              }),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade600),
                            child: const Text("Decline"),
                            onPressed: () {
                              rep = "refused";
                              QuizServices().RefuseUser(widget.user.id);
                              setState(() {});
                              /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UsersEnAttenteInAdmin(
                                  QuizId: user.quizId,
                                ),
                              )); */
                              /*  Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlayQuiz(
                                        idQuiz: quiz.quizId,
                                      )),
                              (route) => false); */
                            },
                          ),
                        ],
                      ),
                    )
                  : rep == "accepted"
                      ? const Text(
                          "Accepted ",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w500),
                        )
                      : const Text(
                          "Refused",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
