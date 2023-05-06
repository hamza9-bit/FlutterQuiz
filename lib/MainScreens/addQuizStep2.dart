import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzapp2/Models/QuizModel.dart';

import '../Providers/Services/QuizServices.dart';
import '../Providers/adminProvider.dart';
import 'listOfQuizes.dart';
import '../Models/Question.dart';
import '../Utils_Widgets/QuestionCard.dart';

class AddQuizStep2 extends StatefulWidget {
  const AddQuizStep2({super.key});

  @override
  State<AddQuizStep2> createState() => _AddQuizStep2State();
}

int numQ = 0;
bool selectedRep = true;

List<String> listOfValues = ["Faux", "Vrai"];
String DropSelectedRep = listOfValues.first;
TextStyle style = const TextStyle(fontFamily: 'Aerial', fontSize: 20.0);
TextEditingController tx = TextEditingController();

class _AddQuizStep2State extends State<AddQuizStep2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text("Create Quiz",
            style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: (numQ == 5)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Quiz name : ",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            Provider.of<AdminProvider>(context, listen: false)
                                .QuizName,
                            style: const TextStyle(
                                fontSize: 35, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      indent: 5,
                      endIndent: 5,
                      height: 10,
                      thickness: 2,
                    ),
                    ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            Provider.of<AdminProvider>(context, listen: false)
                                .QuizQuestions
                                .length,
                        itemBuilder: (BuildContext context, int index) {
                          return QuestionCard(
                              q: Provider.of<AdminProvider>(context,
                                      listen: false)
                                  .QuizQuestions[index]);
                        }),
                    Consumer<AdminProvider>(
                      builder: (context, AdminProvider, _) {
                        return Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: ElevatedButton.icon(
                                icon: const Icon(Icons.done_all),
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(150, 50)),
                                label: const Text("Confirm Question"),
                                onPressed: () {
                                  // saving quiz data base

                                  QuizServices().addNewQuiz(Quiz(
                                      quizName: AdminProvider.QuizName,
                                      quizId: AdminProvider.QuizId,
                                      questions:
                                          AdminProvider.QuizQuestions.map(
                                              (e) => e.toMap()).toList(),
                                      players: [],
                                      currentQuestion: 0));

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ListOfQuizes()),
                                      (route) => false);
                                },
                              ),
                            ));
                      },
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: SizedBox(
                          height: 250,
                          child: Image.asset(
                            "images/question.gif",
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "Question #${(numQ + 1).toString()}",
                        style: const TextStyle(fontSize: 50),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 0.2,
                            blurRadius: 2,
                            blurStyle: BlurStyle.normal,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextFormField(
                          validator: (value) {},
                          controller: tx,
                          decoration: const InputDecoration(
                              hintText: "Your Question",
                              icon: Icon(
                                Icons.question_mark,
                                color: Colors.black,
                                size: 30,
                              ),
                              border: InputBorder.none),
                          keyboardType: TextInputType.name,
                          onChanged: (newValue) {}),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "   Correct answer is: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            spreadRadius: 0.2,
                            blurRadius: 2,
                            blurStyle: BlurStyle.normal,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: DropdownButton(
                          value: DropSelectedRep,
                          items: listOfValues
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 107, 106, 106)),
                                ),
                              ),
                            );
                          }).toList(),
                          isExpanded: true,
                          onChanged: (value) {
                            DropSelectedRep = value!.toString();
                            selectedRep = (value == "Faux") ? false : true;
                            setState(() {});
                          }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Material(
                          elevation: 9.0,
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.deepPurple[400],
                          child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width * 0.5,
                              padding: const EdgeInsets.fromLTRB(
                                  20.0, 15.0, 20.0, 15.0),
                              child: Text("Next Question ->",
                                  textAlign: TextAlign.center,
                                  style: style.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              onPressed: () {
                                if (tx.text.toString() != "") {
                                  setState(() {
                                    numQ++;
                                    //save Question

                                    Provider.of<AdminProvider>(context,
                                            listen: false)
                                        .addQuestion(Question(
                                            question: tx.text.toString(),
                                            rep: selectedRep));
                                    tx.clear();
                                  });
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: const Text(
                                        "Need to fill the question first !"),
                                    behavior: SnackBarBehavior.floating,
                                    elevation: 15,
                                    backgroundColor: Colors.red.shade300,
                                  ));
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
