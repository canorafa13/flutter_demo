class Entity{
  final String tableName;
  final List<ColumnInfo> values;


  const Entity({required this.tableName, required this.values});
}


class ColumnInfo{
  final String name;
  final TypeOf typeOf;
  final bool isNull;
  final String defaultValuee;

  const ColumnInfo({bool isNullable = true, String defaultValue = "", required this.name, required this.typeOf}): isNull = isNullable, defaultValuee = defaultValue;
}

class PrimaryKey extends ColumnInfo {
  final bool isAutoincrement;

  const PrimaryKey({required super.name, required super.typeOf, required this.isAutoincrement, super.isNullable = false});
  
}

enum DefaultValues{
  datetimeNow(value: "(cast(strftime('%s','now') as int))");

  final String value;

  const DefaultValues({required this.value});
}


enum TypeOf{
  integer(type: "INTEGER"),
  text(type: "TEXT"),
  datetime(type: "INTEGER");

  final String type;

  const TypeOf({required this.type});
}