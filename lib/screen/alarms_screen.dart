import 'package:flutter/material.dart';
import 'package:projectbudy/components/common_bottom_navigaton_bar.dart';

class AlarmsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Alarms"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: "Add new alarm", // TODO translations
            onPressed: () => print("add alarm pressed"),
          )
        ],
      ),
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
