import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/widgets/I18nText.dart';
import 'package:projectbudy/util/colors.dart';

class UndoSnackBar extends SnackBar {
  final VoidCallback onPressed;
  final BuildContext context;

  static void show({BuildContext context, VoidCallback onPressed}) {
    Scaffold.of(context).showSnackBar(UndoSnackBar._(onPressed: onPressed, context: context));
  }

  UndoSnackBar._({this.onPressed, this.context})
      : super(
          content: I18nText("undoSnackbarAlarmDeletedContent"),
          duration: Duration(seconds: 5),
          backgroundColor: CommonColors.snackbarSurface,
          action: SnackBarAction(
            onPressed: onPressed,
            label: FlutterI18n.translate(context, "undoSnackbarActionLabel"),
            textColor: CommonColors.snackbarAction,
          ),
        );
}
