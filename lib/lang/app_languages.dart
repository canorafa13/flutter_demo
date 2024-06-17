// ignore_for_file: constant_identifier_names

import 'dart:ui';

enum AppLanguages {
  ES(code: "es", locale: Locale("es"));

  final String code;
  final Locale locale;

  const AppLanguages({required this.code, required this.locale});

}