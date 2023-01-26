import 'package:cached_network_image/cached_network_image.dart';
import 'package:choices/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<UserModel> users = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;
    TextEditingController searchFieldController = TextEditingController();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              controller: searchFieldController,
              onFieldSubmitted: (value) => searchChangeEvent(value, db),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemBuilder: (context, index) {
                var user = users[index];
                return SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: ListTile(
                    leading: user.photoURL != null
                        ? CachedNetworkImage(
                            imageUrl: user.photoURL!,
                          )
                        : const Icon(Icons.flutter_dash),
                    title: Text(user.displayName),
                  ),
                );
              },
              itemCount: users.length,
            ),
          )
        ],
      ),
    );
  }

  Future<void> searchChangeEvent(
      String searchValue, FirebaseFirestore db) async {
    CollectionReference<UserModel> usersCollection =
        db.collection("users").withConverter(
              fromFirestore: UserModel.fromFirestore,
              toFirestore: (UserModel value, options) => value.toFirestore(),
            );
    var usersSnapshots = await usersCollection
        .where('displayName', isEqualTo: searchValue)
        .get(const GetOptions(source: Source.serverAndCache));
    var usersData = usersSnapshots.docs.map((e) => e.data()).toList();
    setState(() {
      users = usersData;
    });
  }
}
