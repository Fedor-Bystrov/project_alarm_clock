import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter_test/flutter_test.dart' as ft;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:projectbudy/service/alarm_manager.dart';
import 'package:projectbudy/state/alarms.dart';
import 'package:projectbudy/model/alarm.dart';

const alarmsJson = [
  '{"id": 0, "time": "2012-02-27T08:29:00.000", "repeat": "Mon", "label": "Don’t Sleep", "enabled": false}',
  '{"id": 1, "time": "2012-02-27T18:20:00.000", "repeat": "Every Day", "label": "Alarm", "enabled": true}',
  '{"id": 2, "time": "2020-05-17T23:26:00.000", "repeat": null, "label": "Alarm", "enabled": false}'
];

List<Alarm> parseAlarms(List<String> alarmsPre) =>
    alarmsJson.map((a) => json.decode(a)).map((a) => Alarm.fromJson(a)).toList();

class MockAlarmManager extends Mock implements AlarmManager {}

void main() async {
  ft.TestWidgetsFlutterBinding.ensureInitialized();

  final mockAlarmManager = MockAlarmManager();
  when(mockAlarmManager.addAlarm(any)).thenAnswer((realInvocation) async => null);
  AlarmManager.mockAlarmManager(mockAlarmManager);

  group('AlarmsState', () {
    test('AlarmsState#alarms getter returns all alarms', () async {
      SharedPreferences.setMockInitialValues({AlarmsState.alarmsKey: alarmsJson});

      final sharedPreferences = await SharedPreferences.getInstance();
      final alarmsState = AlarmsState(sharedPreferences);
      final expectedAlarms = parseAlarms(alarmsJson);

      expect(alarmsState.alarmsCount, equals(expectedAlarms.length));
      expect(alarmsState.alarms.length, equals(expectedAlarms.length));
      expect(alarmsState.alarms, equals(expectedAlarms));
      expect(alarmsState.alarms is UnmodifiableSetView<Alarm>, equals(true));
    });

    test('AlarmsState#switchAlarm disables/enables alarms', () async {
      SharedPreferences.setMockInitialValues({AlarmsState.alarmsKey: alarmsJson});

      final sharedPreferences = await SharedPreferences.getInstance();
      final initialAlarmsState = AlarmsState(sharedPreferences);
      final expectedAlarms = parseAlarms(alarmsJson)..sort((a, b) => a.time.compareTo(b.time));

      var alarms = initialAlarmsState.alarms.toList();
      expect(alarms[0].enabled, equals(expectedAlarms[0].enabled));
      expect(alarms[1].enabled, equals(expectedAlarms[1].enabled));
      expect(alarms[2].enabled, equals(expectedAlarms[2].enabled));

      // inverting alarm enabled property
      for (var i = 0; i < initialAlarmsState.alarms.length; i++) {
        initialAlarmsState.switchAlarm(alarms[i], !alarms[i].enabled);
      }

      alarms = initialAlarmsState.alarms.toList();
      expect(alarms[0].enabled, equals(!expectedAlarms[0].enabled));
      expect(alarms[1].enabled, equals(!expectedAlarms[1].enabled));
      expect(alarms[2].enabled, equals(!expectedAlarms[2].enabled));

      // checking that enabled property was persisted
      final updatedAlarmsState = AlarmsState(sharedPreferences);

      alarms = updatedAlarmsState.alarms.toList();

      expect(alarms[0].enabled, equals(!expectedAlarms[0].enabled));
      expect(alarms[1].enabled, equals(!expectedAlarms[1].enabled));
      expect(alarms[2].enabled, equals(!expectedAlarms[2].enabled));
    });

    test('AlarmsState#addAlarm adds and persists an alarm', () async {
      int nextAlarmId = alarmsJson.length;
      SharedPreferences.setMockInitialValues({
        AlarmsState.alarmsKey: alarmsJson,
        AlarmsState.nextAlarmIdKey: nextAlarmId,
      });

      final sharedPreferences = await SharedPreferences.getInstance();
      final initialState = AlarmsState(sharedPreferences);
      final expectedAlarms = parseAlarms(alarmsJson)..sort((a, b) => a.time.compareTo(b.time));

      expect(initialState.alarms.toList(), equals(expectedAlarms));

      final newAlarm = Alarm(DateTime.parse("2000-01-01 01:01:01"), "Mon Wed Fri", "Alala", true);

      await initialState.addAlarm(newAlarm);

      // check alarm id
      expect(newAlarm.id, equals(nextAlarmId));
      expect(initialState.alarmsCount, equals(expectedAlarms.length + 1));

      expectedAlarms
        ..add(newAlarm)
        ..sort((a, b) => a.time.compareTo(b.time));
      expect(initialState.alarms.toList(), equals(expectedAlarms));

      // reloading alarms from sharedPreferences
      final updatedState = AlarmsState(sharedPreferences);
      expect(updatedState.alarms.toList(), equals(expectedAlarms));
    });

    test('AlarmsState#addAlarm id generation', () async {
      SharedPreferences.setMockInitialValues({
        AlarmsState.alarmsKey: null,
        AlarmsState.nextAlarmIdKey: null,
      });
      final sharedPreferences = await SharedPreferences.getInstance();
      final initialState = AlarmsState(sharedPreferences);

      final newAlarm0 = Alarm(DateTime.parse("2000-01-01 01:01:01"), "Mon Wed Fri", "0", true);
      await initialState.addAlarm(newAlarm0);
      // check alarm id
      expect(newAlarm0.id, equals(0));
      expect(initialState.alarmsCount, equals(1));

      final newAlarm1 = Alarm(DateTime.parse("2000-01-01 01:01:02"), "Mon Wed Fri", "1", true);
      await initialState.addAlarm(newAlarm1);
      // check alarm id
      expect(newAlarm1.id, equals(1));
      expect(initialState.alarmsCount, equals(2));

      final newAlarm2 = Alarm(DateTime.parse("2000-01-01 01:01:03"), "Mon Wed Fri", "2", true);
      await initialState.addAlarm(newAlarm2);
      // check alarm id
      expect(newAlarm2.id, equals(2));
      expect(initialState.alarmsCount, equals(3));

      // reloading alarms from sharedPreferences
      final updatedState = AlarmsState(sharedPreferences);
      expect(updatedState.alarmsCount, equals(3));

      final alarms = updatedState.alarms.toList();
      expect(alarms[0].id, equals(0));
      expect(alarms[1].id, equals(1));
      expect(alarms[2].id, equals(2));
    });

    test('AlarmsState#deleteAlarm deletes and persists alarms', () async {
      SharedPreferences.setMockInitialValues({AlarmsState.alarmsKey: alarmsJson});

      final sharedPreferences = await SharedPreferences.getInstance();
      var state = AlarmsState(sharedPreferences);
      final expectedAlarms = parseAlarms(alarmsJson)..sort((a, b) => a.time.compareTo(b.time));
      var alarms = state.alarms.toList();

      expect(alarms, equals(expectedAlarms));

      // delete last alarm
      await state.deleteAlarm(alarms[state.alarmsCount - 1]);

      alarms = state.alarms.toList();
      expect(state.alarmsCount, equals(2));
      expect(alarms[0], equals(expectedAlarms[0]));
      expect(alarms[1], equals(expectedAlarms[1]));

      // reloading alarms from sharedPreferences
      state = AlarmsState(sharedPreferences);

      alarms = state.alarms.toList();
      expect(state.alarmsCount, equals(2));
      expect(alarms[0], equals(expectedAlarms[0]));
      expect(alarms[1], equals(expectedAlarms[1]));

      // delete one more alarm
      await state.deleteAlarm(alarms[state.alarmsCount - 1]);

      alarms = state.alarms.toList();
      expect(state.alarmsCount, equals(1));
      expect(alarms[0], equals(expectedAlarms[0]));

      // reloading alarms from sharedPreferences
      state = AlarmsState(sharedPreferences);

      alarms = state.alarms.toList();
      expect(state.alarmsCount, equals(1));
      expect(alarms[0], equals(expectedAlarms[0]));

      // delete last alarm
      await state.deleteAlarm(alarms[state.alarmsCount - 1]);

      expect(state.alarmsCount, equals(0));

      // reloading alarms from sharedPreferences
      state = AlarmsState(sharedPreferences);

      expect(state.alarmsCount, equals(0));
    });

    test('AlarmsState test alarms sorting', () async {
      SharedPreferences.setMockInitialValues({
        AlarmsState.alarmsKey: null,
        AlarmsState.nextAlarmIdKey: null,
      });
      final sharedPreferences = await SharedPreferences.getInstance();
      final initialState = AlarmsState(sharedPreferences);

      final newAlarm0 = Alarm(DateTime.parse("2000-01-01 01:01:02"), "Mon Wed Fri", "0", true);
      final newAlarm1 = Alarm(DateTime.parse("2000-01-01 01:01:03"), "M2on W11ed Fri", "1", false);
      final newAlarm2 = Alarm(DateTime.parse("2000-01-01 01:01:01"), "Mon W11ed Fri", "2", true);
      final newAlarm3 = Alarm(DateTime.parse("2000-01-01 00:00:00"), "Mon We34d Fri", "3", false);

      await initialState.addAlarm(newAlarm0);
      await initialState.addAlarm(newAlarm3);
      await initialState.addAlarm(newAlarm1);
      await initialState.addAlarm(newAlarm2);

      expect(initialState.alarmsCount, equals(4));

      var alarms = initialState.alarms.toList();
      expect(alarms[0], equals(newAlarm3));
      expect(alarms[1], equals(newAlarm2));
      expect(alarms[2], equals(newAlarm0));
      expect(alarms[3], equals(newAlarm1));

      expect(alarms[0].id, equals(1));
      expect(alarms[1].id, equals(3));
      expect(alarms[2].id, equals(0));
      expect(alarms[3].id, equals(2));

      // reloading alarms from sharedPreferences
      final updatedState = AlarmsState(sharedPreferences);
      expect(updatedState.alarmsCount, equals(4));

      alarms = updatedState.alarms.toList();
      expect(alarms[0], equals(newAlarm3));
      expect(alarms[1], equals(newAlarm2));
      expect(alarms[2], equals(newAlarm0));
      expect(alarms[3], equals(newAlarm1));

      expect(alarms[0].id, equals(1));
      expect(alarms[1].id, equals(3));
      expect(alarms[2].id, equals(0));
      expect(alarms[3].id, equals(2));
    });
  });
}
