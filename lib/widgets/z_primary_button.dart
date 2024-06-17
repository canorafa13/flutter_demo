import 'package:flutter/material.dart';
import 'package:flutter_application_demo/styles/styles.dart';

class ZPrimaryButton extends StatelessWidget{

  const ZPrimaryButton({super.key, required this.text, required this.onPressed, bool isEnabled = true}) : _isEnabled = isEnabled;

  final String text;

  final VoidCallback? onPressed;

  final bool _isEnabled;


  @override
  Widget build(BuildContext context){
    return TextButton(
      onPressed: _isEnabled ? onPressed : null,
      style: TextButton.styleFrom(
        backgroundColor: _isEnabled ? GColor.primary : GColor.primary800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GDimens.D20),
        ),
      ),
      child: Text(
        text, 
        style: const TextStyle(
          color: GColor.white,
          fontSize: GDimens.D15
        ),
      ),
      
    );
  }
}