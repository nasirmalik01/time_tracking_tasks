import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String LANGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String SPANISH = 'es';
const String GERMAN = 'de';

Future<Locale> setLocale(String languageCode) async {
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode = 'en';
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case SPANISH:
      return const Locale(SPANISH, "");
    default:
      return const Locale(GERMAN, '');
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}
