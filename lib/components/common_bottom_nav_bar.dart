import 'package:flutter/material.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const <BottomNavigationBarItem>[
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