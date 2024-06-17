import 'package:flutter/foundation.dart';

class Console {
  static void log(Object? object){
    if(kDebugMode){
      print(object);
    }
  }
}