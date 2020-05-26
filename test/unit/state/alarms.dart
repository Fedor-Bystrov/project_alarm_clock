import 'dart:collection';
import 'dart:convert';

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
      expect(alarmsState.alarms is UnmodifiableListView<Alarm>, equals(true));
    });

    test('AlarmsState#switchAlarm disables/enables alarms', () async {
      SharedPreferences.setMockInitialValues({AlarmsState.alarmsKey: alarmsJson});

      final sharedPreferences = await SharedPreferences.getInstance();
      final initialAlarmsState = AlarmsState(sharedPreferences);
      final expectedAlarms = parseAlarms(alarmsJson);

      expect(initialAlarmsState.alarms[0].enabled, equals(expectedAlarms[0].enabled));
      expect(initialAlarmsState.alarms[1].enabled, equals(expectedAlarms[1].enabled));
      expect(initialAlarmsState.alarms[2].enabled, equals(expectedAlarms[2].enabled));

      // inverting alarm enabled property
      for (var i = 0; i < initialAlarmsState.alarms.length; i++) {
        initialAlarmsState.switchAlarm(i, !initialAlarmsState.alarms[i].enabled);
      }

      expect(initialAlarmsState.alarms[0].enabled, equals(!expectedAlarms[0].enabled));
      expect(initialAlarmsState.alarms[1].enabled, equals(!expectedAlarms[1].enabled));
      expect(initialAlarmsState.alarms[2].enabled, equals(!expectedAlarms[2].enabled));

      // checking that enabled property was persisted
      final updatedAlarmsState = AlarmsState(sharedPreferences);

      expect(updatedAlarmsState.alarms[0].enabled, equals(!expectedAlarms[0].enabled));
      expect(updatedAlarmsState.alarms[1].enabled, equals(!expectedAlarms[1].enabled));
      expect(updatedAlarmsState.alarms[2].enabled, equals(!expectedAlarms[2].enabled));
    });

    test('AlarmsState#addAlarm adds and persists an alarm', () async {
      SharedPreferences.setMockInitialValues({AlarmsState.alarmsKey: alarmsJson});

      final sharedPreferences = await SharedPreferences.getInstance();
      final initialState = AlarmsState(sharedPreferences);
      final expectedAlarms = parseAlarms(alarmsJson);

      expect(initialState.alarms, equals(expectedAlarms));

      final newAlarm = Alarm(DateTime.parse("2000-01-01 01:01:01"), "Mon Wed Fri", "Alala", true);

      await initialState.addAlarm(newAlarm);
      expect(initialState.alarmsCount, equals(expectedAlarms.length + 1));

      expectedAlarms.add(newAlarm);
      expect(initialState.alarms, equals(expectedAlarms));

      // reloading alarms from sharedPreferences
      final updatedState = AlarmsState(sharedPreferences);
      expect(updatedState.alarms, equals(expectedAlarms));
    });

    test('AlarmsState#deleteAlarm deletes and persists alarms', () async {
      SharedPreferences.setMockInitialValues({AlarmsState.alarmsKey: alarmsJson});

      final sharedPreferences = await SharedPreferences.getInstance();
      var state = AlarmsState(sharedPreferences);
      final expectedAlarms = parseAlarms(alarmsJson);

      expect(state.alarms, equals(expectedAlarms));

      // delete last alarm
      await state.deleteAlarm(state.alarmsCount - 1);

      expect(state.alarmsCount, equals(2));
      expect(state.alarms[0], equals(expectedAlarms[0]));
      expect(state.alarms[1], equals(expectedAlarms[1]));

      // reloading alarms from sharedPreferences
      state = AlarmsState(sharedPreferences);

      expect(state.alarmsCount, equals(2));
      expect(state.alarms[0], equals(expectedAlarms[0]));
      expect(state.alarms[1], equals(expectedAlarms[1]));

      // delete one more alarm
      await state.deleteAlarm(state.alarmsCount - 1);

      expect(state.alarmsCount, equals(1));
      expect(state.alarms[0], equals(expectedAlarms[0]));

      // reloading alarms from sharedPreferences
      state = AlarmsState(sharedPreferences);

      expect(state.alarmsCount, equals(1));
      expect(state.alarms[0], equals(expectedAlarms[0]));

      // delete last alarm
      await state.deleteAlarm(state.alarmsCount - 1);

      expect(state.alarmsCount, equals(0));

      // reloading alarms from sharedPreferences
      state = AlarmsState(sharedPreferences);

      expect(state.alarmsCount, equals(0));
    });
  });
}
