import 'package:get/get.dart';

class BoolOnChange extends GetxController{
  var value = false.obs;
  onChange(bool value) => this.value = value.obs;
}