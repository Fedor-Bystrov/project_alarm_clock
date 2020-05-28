import 'package:flutter/material.dart';
import 'package:projectbudy/util/colors.dart';

class UndoSnackBar extends SnackBar {
  final VoidCallback onPressed;

  static void show({BuildContext context, VoidCallback onPressed}) {
    Scaffold.of(context).showSnackBar(UndoSnackBar._(onPressed: onPressed));
  }

  UndoSnackBar._({this.onPressed})
      : super(
          content: const Text("Alarm deleted"), // TODO translation
          duration: Duration(seconds: 5),
          backgroundColor: CommonColors.snackbarSurface,
          action: SnackBarAction(
            onPressed: onPressed,
            label: "UNDO", // TODO translation
            textColor: CommonColors.snackbarAction,
          ),
        );
}
