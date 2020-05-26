import 'package:android_alarm_manager/android_alarm_manager.dart';

import 'package:projectbudy/model/alarm.dart';

class AlarmManager {
  static AlarmManager _instance = AlarmManager._();

  AlarmManager._();

  static AlarmManager getInstance() {
    return _instance;
  }

  static mockAlarmManager(AlarmManager alarmManager) {
    _instance = alarmManager;
  }

  Future<void> addAlarm(Alarm alarm) async {
    return AndroidAlarmManager.oneShotAt(
      // TODO don't fire immediately  after creation
      alarm.time,
      alarm.id, // TODO Track alarm Ids
      _callback,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  Future<bool> cancel(Alarm alarm) async {
    return AndroidAlarmManager.cancel(alarm.id);
  }

  static void _callback(int id) {
    print("Alarm $id fired");
  }
}
