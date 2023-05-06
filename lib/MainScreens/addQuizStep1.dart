import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/Services/QuizServices.dart';
import '../Providers/adminProvider.dart';
import 'addQuizStep2.dart';

class AddQuizStep1 extends StatefulWidget {
  const AddQuizStep1({super.key});

  @override
  State<AddQuizStep1> createState() => _AddQuizStep1State();
}

TextEditingController tx = TextEditingController();
TextStyle style = const TextStyle(fontFamily: 'Aerial', fontSize: 20.0);
String newQuizId = '';

class _AddQuizStep1State extends State<AddQuizStep1> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SizedBox(
                    height: 200,
                    child: Image.asset(
                      "images/quizName.gif",
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              const Center(
                child: Text(
                  "Quiz Name",
                  style: TextStyle(fontSize: 50),
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
                        hintText: "Your Quiz name",
                        icon: Icon(Icons.abc, color: Colors.black, size: 35),
                        border: InputBorder.none),
                    keyboardType: TextInputType.name,
                    onChanged: (newValue) {}),
              ),
              if (newQuizId != '')
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "The Quiz Code is:   $newQuizId",
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Material(
                    elevation: 9.0,
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.deepPurple[400],
                    child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width * 0.5,
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        child: Text(
                            (newQuizId == '')
                                ? "Generate Code"
                                : "Add Questions",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          if (tx.text.toString() == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  const Text("Need to fill the quiz name !"),
                              behavior: SnackBarBehavior.floating,
                              elevation: 15,
                              backgroundColor: Colors.red.shade300,
                            ));
                          }
                          if (tx.text.toString() != "" && newQuizId != '') {
                            setState(() {
                              Provider.of<AdminProvider>(context, listen: false)
                                  .saveNameQuiz(tx.text, newQuizId);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddQuizStep2()),
                              );
                            });
                          }

                          if (tx.text.toString() != "" && newQuizId == '') {
                            newQuizId = QuizServices.generateRandomId();

                            setState(() {});
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
