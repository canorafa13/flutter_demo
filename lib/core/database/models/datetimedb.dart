class DateTimeDB{
  final String value;
  
  const DateTimeDB({required this.value});
  
  factory DateTimeDB.now(){
    return DateTimeDB(value: DateTime.now().toString());
  }

  factory DateTimeDB.fromInt(int seconds){
    return DateTimeDB(value: DateTime.fromMillisecondsSinceEpoch(seconds).toString());
  }

  factory DateTimeDB.fromDynamic(dynamic value){
    if(value is int){
      return DateTimeDB.fromInt(value);
    }
    return value;
  }

  /*int currentTimeInSeconds() {
    var ms = DateTime.now().millisecondsSinceEpoch;
    return (ms / 1000).round();
  }*/

  /// La fecha en segundos
  int timeInSeconds(){
    var ms = DateTime.parse(value).millisecondsSinceEpoch;
    return (ms / 1000).round();
  }

  /// La fecha en DateTime
  DateTime secondsToDateTime(){
    final seconds = timeInSeconds();
    return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
  }
}