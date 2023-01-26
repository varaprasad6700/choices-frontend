import 'package:choices/profile_page.dart';
import 'package:choices/search_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int selectedIndex) {
          setState(() {
            currentIndex = selectedIndex;
          });
        },
        selectedIndex: currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.search), label: 'search'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'chat')
        ],
      ),
      body: <Widget>[
        const ProfilePage(),
        const SearchPage(),
        Container(),
      ][currentIndex],
    );
  }
}
