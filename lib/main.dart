import 'package:choices/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline4: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 60,
            shadows: [
              const Shadow(
                offset: Offset(3, 3),
                color: Colors.black38,
                blurRadius: 10,
              ),
              Shadow(
                offset: const Offset(-3, -3),
                color: Colors.white.withOpacity(0.85),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
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
                  child: Text("getToken"),
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
      },
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
