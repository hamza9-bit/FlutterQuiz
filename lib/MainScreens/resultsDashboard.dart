import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzapp2/MainScreens/listOfQuizes.dart';
import 'package:quizzapp2/MainScreens/userRegistration.dart';

import '../Providers/Services/QuizServices.dart';
import '../Providers/adminProvider.dart';
import '../Providers/simplePlayerProvider.dart';

class ResultsDashboard extends StatefulWidget {
  const ResultsDashboard({super.key});

  @override
  State<ResultsDashboard> createState() => _ResultsDashboardState();
}

class _ResultsDashboardState extends State<ResultsDashboard> {
  @override
  Widget build(BuildContext context) {
    print(QuizServices().getQuizScore(
        Provider.of<AdminProvider>(context, listen: false)
            .adminLoged
            .toString()));

    print(Provider.of<AdminProvider>(context, listen: false).quizName);
    print(Provider.of<SimplePlayerProvider>(context, listen: false)
        .userEnAttente
        .quizName);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Results',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
                onPressed: () {
                  if (!Provider.of<AdminProvider>(context, listen: false)
                      .adminLoged) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserRegistration()),
                        (route) => false);
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListOfQuizes()),
                        (route) => false);
                  }
                },
                icon: const Icon(
                  Icons.play_circle,
                  size: 30,
                ),
                label: const Text(
                  "New Quiz",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[
              if (!Provider.of<AdminProvider>(context, listen: false)
                  .adminLoged) ...[
                const SizedBox(height: 20),
                const Text(
                  'Quiz name Leaderboard',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: const [
                            Text(
                              'Your Rank',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "Player Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Points',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Consumer<SimplePlayerProvider>(
                            builder: (context, player, _) {
                          return Row(
                            children: <Widget>[
                              const Text(
                                "*",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                player.userEnAttente.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${player.userEnAttente.score}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              const Text(
                'All leaderboard results',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: const <Widget>[
                          Text(
                            'Rank',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Points',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder(
                          future: QuizServices().getQuizScore(
                              Provider.of<AdminProvider>(context, listen: false)
                                      .adminLoged
                                  ? Provider.of<AdminProvider>(context,
                                          listen: false)
                                      .quizName
                                  : Provider.of<SimplePlayerProvider>(context,
                                          listen: false)
                                      .userEnAttente
                                      .quizName),
                          builder: (context, snapshot) {
                            var res = snapshot.data as Map<String, dynamic>;
                            List<dynamic> theList =
                                res["players"] as List<dynamic>;
                            theList.sort(
                                (a, b) => b['score'].compareTo(a['score']));
                            print(theList);
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: theList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Text(
                                        '${index + 1}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        theList.elementAt(index)["name"]!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        theList
                                            .elementAt(index)["score"]
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ]),
                                  ],
                                );
                              },
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
