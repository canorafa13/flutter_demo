import 'dart:math';

class AppRandom{
  static String randomString(int size){
    const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(size, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }
}

