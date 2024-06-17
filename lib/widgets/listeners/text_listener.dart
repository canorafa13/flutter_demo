import 'package:flutter/material.dart';
import 'package:flutter_application_demo/widgets/getx/text_on_change.getx.dart';

class TextListener{
  TextEditingController controller = TextEditingController();
  TextOnChange? textOnChange;

  TextListener({TextEditingController? textEditingController, this.textOnChange}) {
    textEditingController ??= TextEditingController();
    controller = textEditingController;
  }
}