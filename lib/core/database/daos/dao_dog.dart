import 'package:flutter_application_demo/core/database/daos/dao_base.dart';
import 'package:flutter_application_demo/core/database/models/datetimedb.dart';
import 'package:flutter_application_demo/core/models/dog.dart';
import 'package:flutter_application_demo/utils/app_typedef.dart';
import 'package:flutter_application_demo/utils/extensions/extension_map.dart';
import 'package:sqflite/sqflite.dart';

class DaoDog with DaoBase{

  DaoDog(){ tableName = Dog.entity.tableName; }
  
  createDog(Dog dog, Resolve<int> resolve) =>
    create(dog.toMap().removeKey("id") as Map<String, Object?>, conflictAlgorithm: ConflictAlgorithm.fail, resolve: resolve);

  findAllDogs(Resolve<List<Dog>> resolve) => read(Dog.fromMap, orderBy: "id", resolve: resolve);

  findDog(int id, Resolve<Dog?> resolve) => 
    readOne(Dog.fromMap, where: "id = ?", whereArgs: [id], resolve: resolve);

  updateDog(Dog dog, Resolve<int> resolve) {
    dog.updateAt = DateTimeDB.now();
    update(dog.toMap().removeKey("id").removeKey("createAt") as Map<String, Object?>, where: "id = ?", whereArgs: [dog.id], conflictAlgorithm: ConflictAlgorithm.fail, resolve: resolve);
  }

  deleteDog(int id, Resolve<int> resolve) => 
    delete(where: "id = ?", whereArgs: [id], resolve: resolve);
}