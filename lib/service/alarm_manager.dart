import 'package:android_alarm_manager/android_alarm_manager.dart';

import 'package:projectbudy/model/alarm.dart';

class AlarmManager {
  static Future<void> addAlarm(Alarm alarm) async {
    AndroidAlarmManager.oneShotAt(
        // TODO don't fire immediately  after creation
        alarm.time,
        1, // TODO Track alarm Ids
        _callback,
        exact: true,
        wakeup: true,
        rescheduleOnReboot: true);
  }

  static void _callback(int id) {
    print("Alarm $id fired");
  }
}
