import 'package:flutter/material.dart';
import 'package:projectbudy/components/common_bottom_nav_bar.dart';
import 'package:projectbudy/components/common_app_bar.dart';

class AlarmsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      bottomNavigationBar: CommonBottomNavigationBar(),
      body: Center(
          child: Column(
        children: [
          Text("body"),
        ],
      )),
    );
  }
}
