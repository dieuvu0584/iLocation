import 'package:flutter/material.dart';

/// Converts between the flat locale-code strings used in SharedPreferences /
/// the language dropdown (matching each `app_<code>.arb` filename, e.g.
/// `zh_Hant`) and real [Locale] objects. Most of the ~35 supported languages
/// are a plain language code, but Chinese needs a script subtag (`Hant`),
/// which [Locale]'s constructor does not parse out of an underscored string
/// on its own.
Locale localeFromCode(String code) {
  final parts = code.split('_');
  if (parts.length == 2 && parts[1].length == 4) {
    return Locale.fromSubtags(languageCode: parts[0], scriptCode: parts[1]);
  }
  return Locale(code);
}

String localeToCode(Locale locale) {
  return locale.scriptCode != null ? '${locale.languageCode}_${locale.scriptCode}' : locale.languageCode;
}
