import 'package:flutter/material.dart';
import 'package:flutter_application_demo/lang/app_localizations.dart';
import 'package:flutter_application_demo/lang/app_strings.dart';

extension TranslateWhoutArgs on AppStrings {
  String tr(BuildContext context) {
    return AppLocalizations.of(context)?.translate(value) ?? "";
  }
}

extension TranslateWithArg on AppStrings {
  String trWithArg(BuildContext context, Map<String, dynamic> args) {
    return AppLocalizations.of(context)?.translateWithArgs(value, args) ?? "";
  }
}