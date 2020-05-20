import 'package:flutter/material.dart';

import 'package:projectbudy/model/alarm.dart';
import 'package:projectbudy/util/utils.dart';

class AlarmTileTitle extends StatelessWidget {
  final Alarm _alarm;

  AlarmTileTitle(this._alarm);

  @override
  Widget build(BuildContext context) {
    return Text(
      getDateFormat(context).format(_alarm.time),
      style: const TextStyle(fontSize: 24.0),
    );
  }
}
