import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../dbhelper/dbhelper.dart';
import 'AuthorQuote.dart';
import 'FavoriteQuote.dart';
import 'SearchQuote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List widgetOptions = [
    AuthorQuote(),
    SearchQuote(),
    FavoriteQuote(),
  ];
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: widgetOptions.elementAt(selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Author Quote',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search Quote',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: onItemTapped,
          ),
        ));
  }
}
