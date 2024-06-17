import 'package:flutter_application_demo/core/database/database.dart';
import 'package:flutter_application_demo/core/database/models/datetimedb.dart';
import 'package:flutter_application_demo/core/models/notifiers/on_result.dart';
import 'package:flutter_application_demo/utils/app_typedef.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

mixin DaoBase{
  String tableName = "";

  void create(Map<String, Object?> values,
    {String? nullColumnHack, ConflictAlgorithm? conflictAlgorithm, Resolve<int>? resolve}) async {
      resolve?.call(Result.loading());
      try{
        final db = await AppDatabase.db();
        final id = await db.insert(tableName, _checkValues(values), conflictAlgorithm: conflictAlgorithm, nullColumnHack: nullColumnHack);
        print("Id nuevo: $id");
        resolve?.call(Result.success(id));
      }catch(err){
        err.printError();
        print("Ocurrio un error al crear: $err");
        resolve?.call(Result.error("Ocurrio un error al crear: $err"));
      }
  }

  void read<T>(
    FromMap<T> fromMap,
    {bool? distinct,
      List<String>? columns,
      String? where,
      List<Object?>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? limit,
      int? offset,
      Resolve<List<T>>? resolve
    }) async {
      resolve?.call(Result.loading());
      try{
        final db = await AppDatabase.db();
        var list = await db.query(tableName, 
          columns: columns, 
          where: where, 
          whereArgs: whereArgs, 
          groupBy: groupBy, 
          having:  having,
          orderBy: orderBy,
          limit: limit,
          offset: offset
        );
        final data = list.map((e) => fromMap(e)).toList();
        resolve?.call(Result.success(data));
      }catch(err){
        err.printError();
        print("Ocurrio un error al crear: $err");
        resolve?.call(Result.error("Ocurrio un erro al obtener datos: $err"));
      }
  }

  void readOne<T>(
    FromMap<T> fromMap,
    {bool? distinct,
      List<String>? columns,
      String? where,
      List<Object?>? whereArgs,
      String? groupBy,
      String? having,
      String? orderBy,
      int? offset,
      Resolve<T?>? resolve
    }) async {
      resolve?.call(Result.loading());
      try{
        final db = await AppDatabase.db();
        var list = await db.query(tableName, 
          columns: columns, 
          where: where, 
          whereArgs: whereArgs, 
          groupBy: groupBy, 
          having:  having,
          orderBy: orderBy,
          limit: 1,
          offset: offset
        );
        final data = list.map((e) => fromMap(e)).toList().firstOrNull;
        resolve?.call(Result.success(data));
      }catch(err){
        err.printError();
        resolve?.call(Result.error("Ocurrio un erro al obtener datos: $err"));
      }
  }

  void update(Map<String, Object?> values,
      {String? where,
      List<Object?>? whereArgs,
      ConflictAlgorithm? conflictAlgorithm,
      Resolve<int>? resolve,
      }) async{
        resolve?.call(Result.loading());
        try{
          final db = await AppDatabase.db();
          final rowsAf = await db.update(tableName, _checkValues(values), where: where, whereArgs: whereArgs, conflictAlgorithm: conflictAlgorithm);
          print(rowsAf);
          resolve?.call(Result.success(rowsAf));
        }catch(err){
          print(err);
          resolve?.call(Result.error("Ocurrio un error al actualizar: $err"));
        }
  }

  void delete({String? where, List<Object?>? whereArgs, Resolve<int>? resolve}) async {
    resolve?.call(Result.loading());
    try {
      final db = await AppDatabase.db();
      final rowsAf = await db.delete(tableName, where: where, whereArgs: whereArgs);
      resolve?.call(Result.success(rowsAf));
    } catch (err) {
      err.printError();
      resolve?.call(Result.error("Ocurrio un error al eliminar: $err"));
    }
  }

  Map<String, Object?> _checkValues(Map<String, Object?> values){
    values.forEach((key, value) { 
      if(value is DateTimeDB){
        values[key] = value.timeInSeconds();
      }
    });
    return values;
  }
}

