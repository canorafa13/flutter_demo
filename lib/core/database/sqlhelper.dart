import 'package:flutter_application_demo/core/database/models/entity.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {
  Future<void> createTables(Database database, List<Entity> entities) async {
    for(var element in entities){
      await database.execute(_sqlTables(element));
    }
  }
  
  String _sqlTables(Entity entity){
    return """CREATE TABLE IF NOT EXISTS ${entity.tableName}(${_columnInfo(entity.values)})""";
  }

  String _columnInfo(List<ColumnInfo> columns){
    List<String> elements = [];
    for (var element in columns) { 
      if(element is PrimaryKey){
        elements.add("${element.name} ${_type(element.typeOf)} PRIMARY KEY ${element.isAutoincrement? "AUTOINCREMENT" : ""} ${_defaultValue(element.defaultValuee, element.typeOf)} NOT NULL");
      } else {
        elements.add("${element.name} ${_type(element.typeOf)} ${_defaultValue(element.defaultValuee, element.typeOf)} ${element.isNull ? "NULL" : "NOT NULL"}");
      }
    }
    return elements.join(", ");
  }

  String _defaultValue(String value, TypeOf typeOf){
    if(value.isEmpty) return "";

    switch(typeOf){
      case TypeOf.integer: return "DEFAULT $value";
      case TypeOf.text: return "DEFAULT '$value'";
      case TypeOf.datetime: return "DEFAULT $value";
    }
  }

  String _type(TypeOf typeOf){
    if(typeOf == TypeOf.datetime){
      return TypeOf.integer.type;
    }
    return typeOf.type;
  }
}