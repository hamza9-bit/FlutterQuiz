import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/Question.dart';
import '../Providers/Services/QuizServices.dart';
import '../Providers/adminProvider.dart';
import '../Providers/simplePlayerProvider.dart';
import 'resultsDashboard.dart';

class PlayQuiz extends StatefulWidget {
  final String idQuiz;

  const PlayQuiz({super.key, required this.idQuiz});
  @override
  _PlayQuizState createState() => _PlayQuizState();
}

class _PlayQuizState extends State<PlayQuiz> {
  var score = 0;
  int currentQ = 0;
  bool isButtonPressed = false;
  List<Question> theList = List.empty(growable: true);
  String? CountAnswers(int totalScore) {
    switch (totalScore) {
      case 100:
        return "An answer is correct";
      case 200:
        return "2 correct answers";
      case 300:
        return "3 correct answers";
      case 400:
        return "4 correct answers";
      case 500:
        return "5 correct answers";

      default:
        print("an unexpected answer");
    }
  }

  checkWin(bool userChoice, BuildContext context) {
    if (userChoice == theList[currentQ].rep) {
      print("correct");

      score = score + 100;
      const snackbar = SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Colors.green,
        content: Text("Correct!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      print("false");
      score = score + 0;
      const snackbar = SnackBar(
        duration: Duration(milliseconds: 500),
        backgroundColor: Colors.red,
        content: Text("Incorrect!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    /*    setState(() {
      if (counter < 9) {
        counter = counter + 1;
      }
    }); */
  }

/*   reset() {
    setState(() {
      counter = 0;
      score = 0;
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Quiz',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFF4F3E3),
      body: Builder(
        builder: (BuildContext context) => Column(
          children: [
            FutureBuilder(
                future: QuizServices().getQuestionsOfQuiz(widget.idQuiz),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    theList = snapshot.data as List<Question>;
                  }
                  return Container();
                }),
            StreamBuilder<Object>(
                stream: QuizServices().guardQuiz(widget.idQuiz),
                builder: (context, snapshot) {
                  currentQ = snapshot.data as int;
                  print(currentQ);

                  if (currentQ < 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 150.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "Starting the Quiz...",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 70,
                          ),
                          /* Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SpinKitFadingCube(
                            color: Colors.deepPurple,
                            size: 50.0,
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            "Please wait admin Authorisation",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ],
                      ),
                    ), */
                          SizedBox(
                              height: 150,
                              width: 150,
                              child: CircularProgressIndicator(
                                color: Colors.deepPurple,
                                strokeWidth: 8.0,
                              )),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    );
                  } else if (currentQ >= 5) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Text(
                            "End Of Quiz",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple.shade700),
                          ),
                        ),
                        Image.asset(
                          "images/endQuiz.png",
                          fit: BoxFit.fitWidth,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton.icon(
                              icon: const Icon(Icons.dashboard),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(200, 50)),
                              onPressed: () {
                                Provider.of<SimplePlayerProvider>(context,
                                        listen: false)
                                    .setScore(score);
// save score in DB

                                if (!Provider.of<AdminProvider>(context,
                                        listen: false)
                                    .adminLoged) {
                                  QuizServices().saveMyScore(
                                      widget.idQuiz,
                                      Provider.of<SimplePlayerProvider>(context,
                                              listen: false)
                                          .userEnAttente);
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResultsDashboard()),
                                );
                              },
                              label: const Text("Show Results",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 300,
                          width: 1500,
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 800),
                            child: Container(
                              key: ValueKey(theList[currentQ]),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    theList[currentQ].question,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border:
                                  Border.all(color: const Color(0xFF2196F3))),
                          height: 90.0,
                          width: 400,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              FittedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (!Provider.of<AdminProvider>(context,
                                            listen: false)
                                        .adminLoged) ...[
                                      Text(
                                        "Score: $score / 500",
                                        style: const TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        CountAnswers(score) ?? "0 answers",
                                        style: const TextStyle(
                                          color: Colors.deepPurple,
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ] else ...[
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          children: [
                                            const Text(
                                              "The correct answer is:  ",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            Text(
                                              "${theList[currentQ].rep}",
                                              style: const TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 30)),
                        if (Provider.of<AdminProvider>(context, listen: false)
                            .adminLoged) ...[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.navigate_next,
                                size: 35,
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.grey, width: 0.3),
                                      borderRadius: BorderRadius.circular(50)),
                                  minimumSize: const Size(100, 50)),
                              label: const Text("Next",
                                  style: TextStyle(fontSize: 18)),
                              onPressed: () {
                                QuizServices()
                                    .nextQuestion(widget.idQuiz, currentQ);
                              },
                            ),
                          ),
                        ],
                        if (!Provider.of<AdminProvider>(context, listen: false)
                            .adminLoged)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              const SizedBox(width: 20),
                              Expanded(
                                child: AnimatedOpacity(
                                  opacity: isButtonPressed ? 0.2 : 1.0,
                                  duration: const Duration(milliseconds: 500),
                                  child: ElevatedButton(
                                    onPressed: isButtonPressed
                                        ? null
                                        : () => checkWin(true, context),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.deepPurple,
                                            Colors.indigo.shade500,
                                            Colors.deepPurple,
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: 100.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "TRUE",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: AnimatedOpacity(
                                  opacity: isButtonPressed ? 0.2 : 1.0,
                                  duration: const Duration(milliseconds: 500),
                                  child: ElevatedButton(
                                    onPressed: isButtonPressed
                                        ? null
                                        : () => checkWin(false, context),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.deepPurple,
                                            Colors.indigo.shade500,
                                            Colors.deepPurple,
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        constraints: const BoxConstraints(
                                            maxWidth: 100.0, minHeight: 50.0),
                                        alignment: Alignment.center,
                                        child: const Text(
                                          "FALSE",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                      ],
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
