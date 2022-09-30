import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? _user;

  @override
  void initState() {
    _user = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Logged in',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _getToken,
                child: const Text("getToken"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _logout,
        tooltip: 'Logout',
        child: const Icon(Icons.logout),
      ),
    );
  }

  void _getToken() {
    if (_user != null) {
      var snackBar = const SnackBar(
        content: Text("Token in console"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _user?.getIdToken().then((value) => print(value));
    }
  }

  void _logout() {
    FirebaseAuth.instance.signOut().catchError((error) {}).then((value) {
      setState(() {
        _user = null;
      });
    });
  }
}
