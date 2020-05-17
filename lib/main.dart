import 'dart:isolate';
import 'dart:ui';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:projectbudy/application.dart';

/// The name associated with the UI isolate's [SendPort].
const String isolateName = 'mainProjectBudiUIisolate';

/// A port used to communicate from a background isolate to the UI isolate.
final ReceivePort receivePort = ReceivePort();

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Register the UI isolate's SendPort to allow for communication from the
  // background isolate.
  bool alarmManagerInitialized = await AndroidAlarmManager.initialize();
  if (!alarmManagerInitialized) {
    throw 'Alarm Manager Not Initialized!'; // TODO error handling, logging
  }
  IsolateNameServer.registerPortWithName(receivePort.sendPort, isolateName);
  var sharedPreferences = await SharedPreferences.getInstance();
  runApp(Application(sharedPreferences));
}
