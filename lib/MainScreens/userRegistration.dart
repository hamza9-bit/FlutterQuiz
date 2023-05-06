import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quizzapp2/Models/UserEnAttente.dart';

import 'package:quizzapp2/MainScreens/login_screen.dart';

import 'package:quizzapp2/MainScreens/waitingAccept.dart';

import '../Providers/Services/QuizServices.dart';
import '../Providers/simplePlayerProvider.dart';
import '../Services/Database.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({Key? key}) : super(key: key);

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quizController = TextEditingController();
  final DatabaseService databaseService = DatabaseService();
  void pushNavToDash({required BuildContext context}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyLoginPage()));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quizController.dispose();
    super.dispose();
  }

  bool btnpressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('QuizUp',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            iconSize: 40,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyLoginPage()));
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 250,
                      child: Image.asset("images/registration.png"),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Your Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _quizController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the quiz name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Quiz Id',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Container(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.grey, width: 0.3),
                                borderRadius: BorderRadius.circular(50)),
                            minimumSize: const Size(150, 70)),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String newId =
                                databaseService.generateRandomUserId(8);
                            UserEnAttente userEnAttente = UserEnAttente(
                              name: _nameController.text,
                              quizName: _quizController.text,
                              accepted: false,
                              id: newId,
                              refused: false,
                              score: 0,
                            );
                            Provider.of<SimplePlayerProvider>(context,
                                    listen: false)
                                .setUser(userEnAttente);
                            //test for quiz exists

                            bool res = await QuizServices()
                                .verifQuizExists(_quizController.text)
                                .then((value) => value);
                            if (res) {
                              Provider.of<SimplePlayerProvider>(context,
                                      listen: false)
                                  .setQuizId(_quizController.text);

                              databaseService
                                  .addUsersEnAttenteToDb(userEnAttente);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          WaitingAccept(theIdOfUser: newId)));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Quiz Id invalid!"),
                                behavior: SnackBarBehavior.floating,
                                elevation: 15,
                                backgroundColor: Colors.redAccent,
                              ));
                              print(
                                  "not Validated"); // there was an error adding the data
                            }
                          }
                        },
                        child: const Text(
                          'Start Quiz',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
