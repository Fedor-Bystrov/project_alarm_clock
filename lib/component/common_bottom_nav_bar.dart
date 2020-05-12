import 'package:flutter/material.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.indigo[500], // TODO extract to static in a separate file
      unselectedItemColor: Colors.black.withOpacity(0.54),
      backgroundColor: Colors.grey[300],
      items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.access_alarms),
        title: Text('Alarms'), // TODO translation
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.group),
        title: Text('Groups'), // TODO translation
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        title: Text('Settings'), // TODO translation
      ),
    ]);
  }

}