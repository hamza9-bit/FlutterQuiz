import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzapp2/Providers/adminProvider.dart';

import 'MainScreens/loadingPage.dart';
import 'Providers/simplePlayerProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAN3cYClyeBKWYtCn2UDRK3TU0ILl4ivTQ",
          appId: "1:428913673008:android:a23ef72016ce59d163bef5",
          messagingSenderId:
              "428913673008-qrfchsnuq76k8jcil55ph5es56odpslg.apps.googleusercontent.com",
          projectId: "tempquiz-1707c"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider = AdminProvider();
    SimplePlayerProvider playerProvider = SimplePlayerProvider();
    return MultiProvider(
      providers: [
        ListenableProvider<AdminProvider>(
          create: (context) => adminProvider,
        ),
        ListenableProvider<SimplePlayerProvider>(
          create: (context) => playerProvider,
        )
      ],
      child: MaterialApp(
          title: 'QuizUp',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: const LoadingPage()),
    );
  }
}
