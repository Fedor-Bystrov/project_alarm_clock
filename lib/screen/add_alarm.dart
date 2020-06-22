import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/model/alarm.dart';
import 'package:projectbudy/state/alarms.dart';
import 'package:projectbudy/widget/appbar/edit_alarm.dart';
import 'package:projectbudy/widget/body/edit_alarm.dart';
import 'package:projectbudy/widget/navbar/bottom.dart';

class AddAlarmScreen extends StatelessWidget {
  static const String id = 'add_alarm';

  @override
  Widget build(BuildContext context) {
    var alarmsState = Provider.of<AlarmsState>(context);
    var alarm = Alarm(DateTime.now(), null, "Alarm", true);
    return Scaffold(
      appBar: EditAlarmAppBar.newAppBar(
        context: context,
        title: I18nText("screenAddAlarmTitle"),
        onPressed: () async {
          await alarmsState.addAlarm(alarm);
          Navigator.pop(context);
        },
      ),
      bottomNavigationBar: BottomNavBar(),
      body: EditAlarmBody(
        context: context,
        alarm: alarm,
      ),
    );
  }
}
