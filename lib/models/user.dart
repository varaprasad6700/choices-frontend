import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  late final String uid;
  late final String displayName;
  late final String email;
  late final String phoneNumber;
  late final String photoURL;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
  });

  factory UserModel.fromUser(User user) {
    return UserModel(
      uid: user.uid,
      displayName: user.displayName!,
      email: user.email!,
      phoneNumber: user.phoneNumber!,
      photoURL: user.photoURL!,
    );
  }

  factory UserModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserModel(
      uid: data?['uid'],
      displayName: data?['displayName'],
      email: data?['email'],
      phoneNumber: data?['phoneNumber'],
      photoURL: data?['photoURL'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid,
      "displayName": displayName,
      "email": email,
      "phoneNumber": phoneNumber,
      "photoURL": photoURL,
    };
  }
}
