import 'package:flutter/material.dart';
import 'package:projectbudy/component/common_bottom_nav_bar.dart';
import 'package:projectbudy/component/common_app_bar.dart';

class AddAlarmScreen extends StatelessWidget {
  static const String id = 'add_alarm';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      bottomNavigationBar: CommonBottomNavigationBar(),
      body: Text('add alarm'),
    );
  }
}
