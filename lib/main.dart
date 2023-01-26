import 'package:choices/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth_gate.dart';

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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const AuthGate();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
