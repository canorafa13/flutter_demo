import 'package:flutter/material.dart';
import 'package:flutter_application_demo/screens/screen_dog/screen_crud_dog.dart';
import 'package:flutter_application_demo/screens/screen_home.dart';
import 'package:flutter_application_demo/screens/screen_login.dart';
import 'package:flutter_application_demo/screens/screen_splash.dart';

class ScreenApp {
  ScreenApp({required this.key, required this.value}){
    key = "screen_app_$key";
  }

  String key;
  final Widget value;
}

class ScreensApp{
  static final ScreenApp splash = ScreenApp(key: "splash", value: ScreenSplash());
  static final ScreenApp login = ScreenApp(key: "login", value: ScreenLogin());
  static final ScreenApp home = ScreenApp(key: "home", value: ScreenHome());
  static final ScreenApp crudDog = ScreenApp(key: "crud_dog", value: ScreenCRUDDog());





  static Map<String, WidgetBuilder> createRoutesMap(BuildContext context){
    Map<String, WidgetBuilder> routes = const <String, WidgetBuilder>{};

    routes = {
      splash.key: (context) => splash.value,
      login.key: (context) => login.value,
      home.key: (context) => home.value,
      crudDog.key: (context) => crudDog.value
    };

    return routes;
  }
}