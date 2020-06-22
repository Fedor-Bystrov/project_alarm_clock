import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:projectbudy/util/colors.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: CommonColors.accentColor,
        unselectedItemColor: CommonColors.blackInactive,
        backgroundColor: CommonColors.primaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.access_alarms),
            title: I18nText("navbar.bottom.access_alarms.title"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.group),
            title: I18nText("navbar.bottom.groups.title"),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            title: I18nText("navbar.bottom.settings.title"),
          ),
        ]);
  }
}
