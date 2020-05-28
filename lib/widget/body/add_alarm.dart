import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:projectbudy/model/alarm.dart';
import 'package:projectbudy/util/colors.dart';
import 'package:projectbudy/util/utils.dart';

class AddAlarmBody extends StatelessWidget {
  final BuildContext context;
  final Alarm alarm;

  AddAlarmBody({@required this.context, @required this.alarm});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height / 4,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.time,
          use24hFormat: is24hFormat(context),
          initialDateTime: alarm.time,
          onDateTimeChanged: (DateTime value) {
            alarm.time = value;
          },
        ),
      ),
    ]..addAll(_getAlarmModifiers(context)));
  }

  static Iterable<Widget> _getAlarmModifiers(BuildContext context) {
    return ListTile.divideTiles(
      context: context,
      tiles: [
        ListTile(
          title: const Text(
            'Repeat', // TODO translation
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('Never'), // TODO translation
          trailing: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: CommonColors.accentColor,
            ),
            onPressed: () {
              print("repeat");
            },
          ),
        ),
        ListTile(
          title: const Text(
            'Sound', // TODO translation
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: const Text('waltz'),
          trailing: IconButton(
            icon: Icon(
              Icons.arrow_forward,
              color: CommonColors.accentColor,
            ),
            onPressed: () {
              print("sound");
            },
          ),
        )
      ],
    );
  }
}
