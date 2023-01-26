import 'package:choices/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'main_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SignInScreen(
            providerConfigs: [
              EmailProviderConfiguration(),
              GoogleProviderConfiguration(
                clientId: "966555663103-m8ch0r60hphpdg3skphnmfu1jk55o8sg",
              )
            ],
          );
        } else {
          storeUserData(snapshot.data, db);
          return const MainPage();
        }
      },
    );
  }

  Future<void> storeUserData(User? data, FirebaseFirestore db) async {
    if (data != null) {
      var collectionReference = db.collection('users').withConverter(
          fromFirestore: UserModel.fromFirestore,
          toFirestore: (UserModel value, options) => value.toFirestore());
      QuerySnapshot<UserModel> users = await collectionReference
          .where('id', isEqualTo: data.uid)
          .get(const GetOptions(source: Source.serverAndCache));
      if (users.size == 0) {
        return collectionReference.doc(data.uid).set(UserModel.fromUser(data));
      }
    }
  }
}
