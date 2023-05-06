import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/QuizModel.dart';
import '../Providers/Services/QuizServices.dart';
import '../Providers/adminProvider.dart';
import '../Utils_Widgets/QuizCard.dart';
import 'UserRegistration.dart';
import 'addQuizStep1.dart';

class ListOfQuizes extends StatelessWidget {
  const ListOfQuizes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          iconSize: 35,
          onPressed: () {
            Provider.of<AdminProvider>(context, listen: false).adminidLoging();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const UserRegistration()),
                (route) => false);
          },
        ),
        centerTitle: true,
        title: const Text("My Quizes",
            style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<Object>(
                  future: QuizServices().getAllSavedQuiz(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      List<Quiz> res = snapshot.data as List<Quiz>;
                      return ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: res.length,
                          itemBuilder: (BuildContext context, int index) {
                            return QuizCard(quiz: res[index]);
                          });
                    }
                    return const SizedBox();
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddQuizStep1()),
          );
        },
        label: const Text("New Quiz", style: TextStyle(fontSize: 18)),
        icon: const Icon(
          Icons.add,
          size: 35,
        ),
        backgroundColor: Colors.deepPurple[400],
      ),
    );
  }
}
