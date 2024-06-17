import 'package:get/get.dart';

class TextOnChange extends GetxController{
  var text = "".obs;
  onChange(String text) => this.text = text.obs;
}