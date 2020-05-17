import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projectbudy/screen/alarms.dart';
import 'package:projectbudy/screen/add_alarm.dart';
import 'package:projectbudy/state/alarms.dart';
import 'package:projectbudy/util/colors.dart';


class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AlarmsState>(create: (_) => AlarmsState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Budy",
        theme: ThemeData(
          primaryColor: CommonColors.primaryColor,
        ),
        initialRoute: AlarmsScreen.id,
        routes: {
          AlarmsScreen.id: (context) => AlarmsScreen(),
          AddAlarmScreen.id: (context) => AddAlarmScreen(),
        },
      ),
    );
  }
}
