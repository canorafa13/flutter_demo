
extension ExtensionString on String {
  String plus(String arg0) {
    return this + arg0;
  }
}

extension ExtensionStringNull on String? {
  String orEmpty(){
    if(this != null) { 
      return this!; 
    } else { 
      return ""; 
    }
  }
}