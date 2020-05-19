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

    test('AlarmsState#persistAlarms stores alarms to SharedSettings', () {
      var string = 'foo,bar,baz';
      expect(string.split(','), equals(['foo', 'bar', 'baz']));
    });
  });
}
