import 'package:flutter/material.dart';

class CommonAppBar extends AppBar {
  CommonAppBar()
      : super(
          centerTitle: true,
          title: Text("Alarms"),
          iconTheme: IconThemeData(color: Colors.indigo[500]),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: "Add new alarm", // TODO translations
              onPressed: () => print("add alarm pressed"),
            )
          ],
        );
}
