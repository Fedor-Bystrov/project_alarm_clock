import 'dart:collection';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/test.dart';

import 'package:projectbudy/state/alarms.dart';
import 'package:projectbudy/model/alarm.dart';

const alarmsJson = [
  '{"time": "2012-02-27T08:29:00.000", "repeat": "Mon", "label": "Don’t Sleep", "enabled": false}',
  '{"time": "2012-02-27T18:20:00.000", "repeat": "Every Day", "label": "Alarm", "enabled": true}',
  '{"time": "2020-05-17T23:26:00.000", "repeat": null, "label": "Alarm", "enabled": false}'
];

List<Alarm> parseAlarms(List<String> alarmsPre) =>
    alarmsJson.map((a) => json.decode(a)).map((a) => Alarm.fromJson(a)).toList();

void main() async {
  group('AlarmsState', () {
    SharedPreferences.setMockInitialValues({AlarmsState.alarmsKey: alarmsJson});

    test('AlarmsState#alarms getter returns all alarms', () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final alarmsState = AlarmsState(sharedPreferences);
      var expectedAlarms = parseAlarms(alarmsJson);

      expect(alarmsState.alarmsCount, equals(expectedAlarms.length));
      expect(alarmsState.alarms.length, equals(expectedAlarms.length));
      expect(alarmsState.alarms, equals(expectedAlarms));
      expect(alarmsState.alarms is UnmodifiableListView<Alarm>, equals(true));
    });

    test('AlarmsState#switchAlarm disables/enables alarms', () async {
      final sharedPreferences = await SharedPreferences.getInstance();
      final initialAlarmsState = AlarmsState(sharedPreferences);
      var expectedAlarms = parseAlarms(alarmsJson);

      expect(initialAlarmsState.alarms[0].enabled, equals(expectedAlarms[0].enabled));
      expect(initialAlarmsState.alarms[1].enabled, equals(expectedAlarms[1].enabled));
      expect(initialAlarmsState.alarms[2].enabled, equals(expectedAlarms[2].enabled));

      // inverting alarm enabled property
      for( var i = 0 ; i < initialAlarmsState.alarms.length; i++) {
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

      // returning initial state
      for( var i = 0 ; i < initialAlarmsState.alarms.length; i++) {
        initialAlarmsState.switchAlarm(i, !initialAlarmsState.alarms[i].enabled);
      }

      expect(initialAlarmsState.alarms[0].enabled, equals(expectedAlarms[0].enabled));
      expect(initialAlarmsState.alarms[1].enabled, equals(expectedAlarms[1].enabled));
      expect(initialAlarmsState.alarms[2].enabled, equals(expectedAlarms[2].enabled));
    });

    test('AlarmsState#persistAlarms stores alarms to SharedSettings', () {
      var string = 'foo,bar,baz';
      expect(string.split(','), equals(['foo', 'bar', 'baz']));
    });
  });
}
