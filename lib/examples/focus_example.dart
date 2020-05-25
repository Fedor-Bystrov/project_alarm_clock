// Flutter code sample for Focus

// This example shows how to manage focus using the [Focus] and [FocusScope]
// widgets. See [FocusNode] for a similar example that doesn't use [Focus] or
// [FocusScope].

import 'package:flutter/material.dart';

//void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: ListView(children: [
        Focus(
          child: Builder(
            builder: (BuildContext context) {
              final FocusNode focusNode = Focus.of(context);
              final bool hasFocus = focusNode.hasFocus;
              return GestureDetector(
                onTap: () {
                  if (hasFocus) {
                    focusNode.unfocus();
                  } else {
                    focusNode.requestFocus();
                  }
                },
                child: Center(
                  child: Container(
                    width: 400,
                    height: 100,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Text(hasFocus ? "I'm in color! Press R,G,B! aaaaa" : 'Press to focus aaaa'),
                  ),
                ),
              );
            },
          ),
        ),
        Focus(
          child: Builder(
            builder: (BuildContext context) {
              final FocusNode focusNode = Focus.of(context);
              final bool hasFocus = focusNode.hasFocus;
              return GestureDetector(
                onTap: () {
                  if (hasFocus) {
                    focusNode.unfocus();
                  } else {
                    focusNode.requestFocus();
                  }
                },
                child: Center(
                  child: Container(
                    width: 400,
                    height: 100,
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Text(hasFocus ? "I'm in color! Press R,G,B! bbbb" : 'Press to focus bbbb'),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
