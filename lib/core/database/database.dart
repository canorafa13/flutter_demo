import "package:flutter_application_demo/core/database/sqlhelper.dart";
import "package:flutter_application_demo/core/models/dog.dart";
import "package:flutter_application_demo/core/storage/app_storage.dart";
import "package:flutter_application_demo/utils/app_random.dart";
import "package:flutter_application_demo/utils/extensions/extension_string.dart";
import "package:sqflite_sqlcipher/sqflite.dart";

// Argumentos unicos para la coniguracion de la base de datos
class AppDatabaseConfig{
  static final SQLHelper _helper = SQLHelper();
  static const String _keyDatabase = "KEY_DATABASE_NAME";
  static const String _keyPassword = "KEY_DATABASE_PASSWORD_RANDOM";
}

// Configuracion de la base de datos
class AppDatabase{

  static Future<Database> db() async {
    /// Obtenermos la contraseña random (unica por instalacion) 
    /// para el cifrado de la base de datos
    var passwordDB = await _getKey(AppDatabaseConfig._keyPassword);
    /// Obtenermos el nombre random (unica por instalacion) 
    /// de la base de datos
    var nameDB = await _getKey(AppDatabaseConfig._keyDatabase);
    
    /// Retorna la instancia de la base de datos
    return openDatabase(
      nameDB.plus(".db"),
      password: passwordDB,
      version: 1,
      onCreate: (db, version) async {
        await AppDatabaseConfig._helper.createTables(db, [
          Dog.entity
        ]);
      },
    );
  }

  static Future<String> _getKey(String key) async {
    var has = await AppStorage.has(key);
    if(!has){
      await AppStorage.write(key, AppRandom.randomString(key.length));
    }
    var passwordDB = await AppStorage.read(key);
    return passwordDB!;
  }

}




/*enum Migration{
  migration_1_2(oldVersion: 1, newVersion: 2);

  final int oldVersion;
  final int newVersion;
  const Migration({required this.oldVersion, required this.newVersion});
}*/