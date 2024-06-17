import 'package:flutter/material.dart';
import 'package:flutter_application_demo/base/base_stateful.dart';
import 'package:flutter_application_demo/widgets/getx/text_on_change.getx.dart';
import 'package:flutter_application_demo/widgets/listeners/text_listener.dart';
import 'package:get/get.dart';

class ZTextFieldParameters {
  
  ZTextFieldParameters({
    required this.label, 
    bool readOnly = _READ_ONLY,
    TextListener? listener,
    bool? isSecret,
    IconData? prefixIcon,
    TextInputAction actionIO = TextInputAction.none,
    TextInputType inputType = TextInputType.text,
    
  }) : 
  _readOnly = readOnly,
  _isSecret = isSecret, 
  _listener = listener,
  _prefixIcon = prefixIcon,
  _actionIO = actionIO,
  _inputType = inputType;

  final String label;
  final bool _readOnly;
  bool? _isSecret;
  TextListener? _listener;
  TextInputAction _actionIO;
  TextInputType _inputType;
  IconData? _prefixIcon;


  static const _IS_SECRET = false;
  static const _READ_ONLY = false;
}


// ignore: must_be_immutable
class ZTextField extends BaseStateful{

  ZTextField({
    super.key, 
    ZTextFieldParameters? parameters
  }) : _parameters = parameters;

  final ZTextFieldParameters? _parameters;

  IconButton? wrapIcon(){
    if(_parameters?._isSecret != null){
      return IconButton(
        icon: Icon(
          (_parameters!._isSecret!)
            ? Icons.visibility
            : Icons.visibility_off
          ),
          onPressed: () => setState(() => _parameters!._isSecret = !_parameters!._isSecret!
        ),
      );
    }
    return null;
  }


  @override
  Widget render(BuildContext context){
    TextOnChange? textOnChange;
    if(_parameters?._listener?.textOnChange != null){
      textOnChange = Get.put(_parameters!._listener!.textOnChange, tag: _parameters?.label.hashCode.toString());
    }



    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        controller: _parameters?._listener?.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          labelText: _parameters?.label,
          suffixIcon: wrapIcon(),
          prefixIcon: _parameters?._prefixIcon != null ? Icon(_parameters!._prefixIcon, size: 24,) : null

        ),
        onChanged: (value) => textOnChange?.onChange(value),
        obscureText: _parameters?._isSecret ?? ZTextFieldParameters._IS_SECRET,
        textInputAction: _parameters?._actionIO,
        keyboardType: _parameters?._inputType,
        readOnly: _parameters?._readOnly ?? ZTextFieldParameters._READ_ONLY,
      ),  
    );
  }
}