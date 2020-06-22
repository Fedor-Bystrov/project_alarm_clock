import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/loaders/decoders/json_decode_strategy.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projectbudy/screen/edit_alarm.dart';
import 'package:projectbudy/state/alarms_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:projectbudy/screen/alarms.dart';
import 'package:projectbudy/screen/add_alarm.dart';
import 'package:projectbudy/state/alarms.dart';
import 'package:projectbudy/util/colors.dart';

class Application extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  Application(this.sharedPreferences);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AlarmsState>(create: (_) => AlarmsState(sharedPreferences)),
        ChangeNotifierProvider<AlarmsListState>(create: (_) => AlarmsListState()),
      ],
      child: FocusScope(
        child: MaterialApp(
          localizationsDelegates: [
            FlutterI18nDelegate(
              translationLoader: FileTranslationLoader(
                basePath: 'assets/i18n',
                useCountryCode: false,
                decodeStrategies: [JsonDecodeStrategy()],
              ),
              missingTranslationHandler: (key, locale) {
                print(
                    "--- Missing Key: $key, languageCode: ${locale.languageCode}"); // TODO error handling
              },
            ),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('en', '') // TODO add more locales
          ],
          debugShowCheckedModeBanner: false,
          title: "Budy",
          theme: ThemeData(
            primaryColor: CommonColors.primaryColor,
          ),
          initialRoute: AlarmsScreen.id,
          routes: {
            AlarmsScreen.id: (context) => AlarmsScreen(),
            AddAlarmScreen.id: (context) => AddAlarmScreen(),
            EditAlarmScreen.id: (context) => EditAlarmScreen(),
          },
        ),
      ),
    );
  }
}
