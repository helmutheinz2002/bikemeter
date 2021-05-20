import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static const List<Locale> supportedLocales = [
    Locale("en"),
    Locale("de"),
  ];

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  final Locale locale;
  Map<String, String> _localizedStrings;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    AppLocalizations appLocalizations =
        Localizations.of<AppLocalizations>(context, AppLocalizations);
    if (appLocalizations == null) {
      print("Locale null");
      return SafeAppLocalizations();
    }
    return appLocalizations;
  }

  String format(dynamic number) {
    NumberFormat f = new NumberFormat('###0.0', locale.languageCode);
    return f.format(number);
  }

  Future<bool> load() async {
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    String s = _localizedStrings[key];
    if (s == null) {
      s = key;
    }
    return s;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    for (Locale l in AppLocalizations.supportedLocales) {
      if (locale.languageCode == l.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class SafeAppLocalizations extends AppLocalizations {
  SafeAppLocalizations() : super(Locale("en"));

  @override
  String translate(String key) {
    return '';
  }
}
