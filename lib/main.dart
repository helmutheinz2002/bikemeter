import 'package:bikemeter/control_panel.dart';
import 'package:bikemeter/dashboard.dart';
import 'package:bikemeter/measure_controller.dart';
import 'package:bikemeter/tab_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'app_localizations.dart';
import 'control_panel.dart';

void main() {
  runApp(Bikemeter());
}

class Bikemeter extends StatefulWidget {
  static const String appName = "Bikemeter";

  @override
  _BikemeterState createState() => _BikemeterState();
}

class _BikemeterState extends State<Bikemeter> {
  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return PlatformApp(
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        isIOS
            ? GlobalCupertinoLocalizations.delegate
            : GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      localeResolutionCallback: selectLocale,
      title: Bikemeter.appName,
      home: TabScaffold(),
    );
  }

  Locale selectLocale(Locale locale, Iterable<Locale> supportedLocales) {
    if (locale != null) {
      for (Locale l in supportedLocales) {
        if (l.languageCode == locale.languageCode) {
          return l;
        }
      }
    }
    return supportedLocales.first;
  }
}
