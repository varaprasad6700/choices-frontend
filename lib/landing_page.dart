import 'package:choices/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? _user;

  @override
  void initState() {
    _user = widget.auth.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference<UserModel> userModelCollectionReference =
        widget.db.collection("users").withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel value, options) => value.toFirestore(),
            );
    return FutureBuilder(
      builder: (ctx, snapshot) {
        late SnackBar snackBar;
        userModelCollectionReference.doc(_user?.uid).get().then(
              (value) => {
                if (value.exists)
                  {
                    snackBar = SnackBar(
                      content: Text("data already exists ${value.data()}"),
                    )
                  }
                else
                  {
                    userModelCollectionReference
                        .doc(_user?.uid)
                        .set(UserModel.fromUser(_user!))
                        .then((value) => {
                              snackBar = const SnackBar(
                                content: Text("Data created succesfully"),
                              )
                            })
                  }
              },
            );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Welcome ${_user?.displayName!}',
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
      },
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
    widget.auth.signOut().catchError((error) {}).then((value) {
      setState(() {
        _user = null;
      });
    });
  }
}
