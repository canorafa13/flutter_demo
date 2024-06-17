import 'package:flutter_application_demo/core/database/models/datetimedb.dart';
import 'package:flutter_application_demo/core/database/models/entity.dart';

class Dog{
  final int id;
  String name;
  int age;
  DateTimeDB? createAt;
  DateTimeDB? updateAt;

  Dog({
    required this.id,
    required this.name,
    required this.age,
    DateTimeDB? createAtt,
    DateTimeDB? updateAtt
  }): updateAt = updateAtt{//, createAt = createAtt;
    createAtt ??= DateTimeDB.now(); //DateTime.now().toString();
    createAt = createAtt;
  }

  

  static Entity entity = const Entity(
    tableName: "Dogs",
    values: [
      PrimaryKey(name: "id", typeOf: TypeOf.integer, isAutoincrement: true),
      ColumnInfo(name: "name", typeOf: TypeOf.text, isNullable: false),
      ColumnInfo(name: "age", typeOf: TypeOf.integer, isNullable: false),
      ColumnInfo(name: "createAt", typeOf: TypeOf.datetime, isNullable: false),
      ColumnInfo(name: "updateAt", typeOf: TypeOf.datetime, isNullable: true)
    ]
  );

  factory Dog.from(String name, int age){
    return Dog(id: 0, name: name, age: age);
  }

  factory Dog.fromMap(Map<String, dynamic> map){
    return Dog(
      id: map["id"], 
      name: map["name"], 
      age: map["age"],
      createAtt: map["createAt"] != null ? DateTimeDB.fromDynamic(map["createAt"]) : null,
      updateAtt: map["updateAt"] != null ? DateTimeDB.fromDynamic(map["updateAt"]) : null
    );
  }

  Map<String, Object?> toMap(){
    return {
      "id": id,
      "name": name,
      "age": age,
      "createAt": createAt?.timeInSeconds(),
      "updateAt": updateAt?.timeInSeconds()
    };
  }

  @override
  String toString(){
    return "{id: $id, name: $name, age: $age, createAt: ${createAt?.value}, updateAt: ${updateAt?.value}}";
  }
}