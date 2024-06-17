import 'package:flutter/material.dart';

class ZContainerIf extends StatelessWidget{
  final Widget widgetTrue;
  final Widget? otherWidget;
  final bool condition;

  const ZContainerIf({super.key, required this.condition, required this.widgetTrue, this.otherWidget});


  @override
  Widget build(BuildContext context) {
    return Container(
      child: condition?
        widgetTrue
      : otherWidget ?? const SizedBox.shrink()
    );
  }

}