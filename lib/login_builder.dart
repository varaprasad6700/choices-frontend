import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginBuilder extends StatefulWidget {
  const LoginBuilder({Key? key}) : super(key: key);

  @override
  State<LoginBuilder> createState() => _LoginBuilderState();
}

class _LoginBuilderState extends State<LoginBuilder> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  User? _user;
  UserCredential? _userCredential;

  @override
  void initState() {
    _user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
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
              onPressed: _getToken,
              child: const Text("getToken"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _login,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _login() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .catchError((error) {
      print(error);
    }).then((value) {
      setState(() {
        print(value);
        _userCredential = value;
        _user = _userCredential?.user;
      });
    });
  }

  void _getToken() {
    if (_user != null) {
      _user?.getIdToken().then((value) => print(value));
    }
  }
}
