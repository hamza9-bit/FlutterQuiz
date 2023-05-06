import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizzapp2/MainScreens/userRegistration.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key, this.title = ""}) : super(key: key);
  final String title;

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  //TextEditingController weightController = TextEditingController();
  //TextEditingController heightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => UserRegistration(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/loadingScreen.gif"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "QuizzUp",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 50.0,
                    color: Colors.purple.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
