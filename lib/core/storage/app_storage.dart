import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppStorage{

  static const FlutterSecureStorage _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true
    )
  );

  static Future<String?> read(String name) async {
    return await _storage.read(key: name);
  }

  static Future<bool> has(String name) async {
    var result = await _storage.read(key: name);
    return result != null;
  }

  static Future<void> write(String name, String value) async {
    await _storage.write(key: name, value: value);
  }

  
}

