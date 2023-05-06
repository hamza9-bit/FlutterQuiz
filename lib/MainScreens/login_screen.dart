import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../Providers/Services/QuizServices.dart';
import '../Providers/adminProvider.dart';
import 'listOfQuizes.dart';

TextStyle style = const TextStyle(fontFamily: 'Aerial', fontSize: 20.0);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyLoginPage(title: 'Login'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key? key, this.title = ""}) : super(key: key);
  final String title;
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController? emailInputController;
  TextEditingController? pwdInputController;
  TextStyle style = const TextStyle(fontFamily: 'Aerial', fontSize: 20.0);

  @override
  initState() {
    emailInputController = TextEditingController();
    pwdInputController = TextEditingController();
    super.initState();
  }

  String? emailValidator(String? value) {
    if (value == "") {
      return "Email format is invalid";
    }
  }

  String? pwdValidator(String? value) {
    /* if (value!.length <= 4) {
      return "Password must be longer than 3 characters";
    } else {
      return "";
    } */
  }
  bool isButtonDisabled = false;
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
          hintText: "Email:",
          filled: true,
          fillColor: Colors.white70,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
      controller: emailInputController,
      keyboardType: TextInputType.emailAddress,
      validator: emailValidator,
    );

    final passwordField = TextFormField(
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
          hintText: "Password:",
          filled: true,
          fillColor: Colors.white70,
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(15.0))),
      controller: pwdInputController,
      validator: pwdValidator,
    );
    final loginButon = Material(
      elevation: 9.0,
      borderRadius: BorderRadius.circular(20.0),
      color: Colors.deepPurple.shade500,
      child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: isButtonDisabled
              ? null
              : () async {
                  print(emailInputController!.text);
                  print(pwdInputController!.text);

                  if (_loginFormKey.currentState!.validate()) {
                    print("form valid");
                    setState(() async {
                      bool res = await QuizServices()
                          .login(emailInputController!.text,
                              pwdInputController!.text)
                          .then((value) => value);
                      if (res) {
                        Provider.of<AdminProvider>(context, listen: false)
                            .adminidLoging();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListOfQuizes()));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(" Please check your infos !"),
                          behavior: SnackBarBehavior.floating,
                          elevation: 15,
                          backgroundColor: Colors.redAccent,
                        ));
                      }
                    });
                  } else {
                    print("form not valid");
                  }
                },
          child: !isButtonDisabled
              ? Text("Login",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold))
              : const CircularProgressIndicator()),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Login admin",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        leading: IconButton(
          color: Colors.white,
          iconSize: 35,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 300,
                width: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("images/loginAdmin.gif"),
                  fit: BoxFit.fitHeight,
                )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Column(
                  children: [
                    const SizedBox(height: 45.0),
                    emailField,
                    const SizedBox(height: 25.0),
                    passwordField,
                    const SizedBox(height: 35.0),
                    loginButon,
                    const SizedBox(height: 25.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
