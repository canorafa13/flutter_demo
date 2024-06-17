
extension ExtensionMap on Map {
  Map<dynamic, dynamic> removeKey(Object? key){
    final temp = this;
    temp.remove(key);
    print(temp);
    return temp;
  }
}