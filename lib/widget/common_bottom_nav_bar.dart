import 'package:flutter/material.dart';

import 'package:projectbudy/util/colors.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: CommonColors.accentColor,
        unselectedItemColor: CommonColors.blackInactive,
        backgroundColor: CommonColors.primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.access_alarms),
            title: const Text('Alarms'), // TODO translation
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.group),
            title: const Text('Groups'), // TODO translation
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            title: const Text('Settings'), // TODO translation
          ),
        ]);
  }
}
