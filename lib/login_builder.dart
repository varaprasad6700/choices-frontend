import 'package:choices/LandingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginBuilder extends StatefulWidget {
  const LoginBuilder({Key? key}) : super(key: key);

  @override
  State<LoginBuilder> createState() => _LoginBuilderState();
}

class _LoginBuilderState extends State<LoginBuilder> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late FirebaseAuth auth;
  late FirebaseFirestore db;
  User? _user;

  @override
  void initState() {
    auth = FirebaseAuth.instance;
    db = FirebaseFirestore.instance;
    _user = auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _user == null
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
              centerTitle: true,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      autofocus: true,
                      controller: emailController,
                    ),
                    TextField(
                      autofocus: true,
                      controller: passwordController,
                    ),
                    ElevatedButton(
                      onPressed: _googleLogin,
                      child: const Text("sign in with google"),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _login,
              tooltip: 'Login',
              child: const Icon(Icons.login),
            ),
          )
        : LandingPage();
  }

  void _login() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        )
        .catchError((error) {})
        .then((value) {
      setState(() {
        _user = value.user;
      });
    });
  }

  void _googleLogin() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
            clientId: "966555663103-m8ch0r60hphpdg3skphnmfu1jk55o8sg")
        .signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance
        .signInWithCredential(credential)
        .catchError((error) {})
        .then((value) {
      setState(() {
        _user = value.user;
      });
    });
  }
}
