import 'package:flutter/material.dart';

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
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Business'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('School'),
        ),
      ]),
      body: Center(
          child: Column(
        children: [
          Text("body"),
        ],
      )),
    );
  }
}
