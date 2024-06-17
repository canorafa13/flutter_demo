import 'package:flutter/material.dart';
import 'package:flutter_application_demo/lang/app_languages.dart';
import 'package:flutter_application_demo/lang/app_strings.dart';
import 'package:flutter_application_demo/screens/screens.dart';
import 'package:flutter_application_demo/lang/app_localizations.dart';
import 'package:flutter_application_demo/screens/state/dog_state.dart';
import 'package:flutter_application_demo/screens/state/login_state.dart';
import 'package:flutter_application_demo/utils/extensions/extension_translate_whout_args.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginState>(create: (_) => LoginState()),
        ChangeNotifierProvider<DogState>(create: (_) => DogState()),
      ],
      child: MaterialApp(
        supportedLocales: [AppLanguages.ES.locale],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (deviceLocale != null &&
                deviceLocale.languageCode == locale.languageCode) {
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        initialRoute: ScreensApp.splash.key,
        routes: ScreensApp.createRoutesMap(context),
        title: AppStrings.FlutterDemo.tr(context),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      )
    );
  }
}
