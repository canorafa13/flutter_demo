import 'package:flutter/material.dart';
import 'package:flutter_application_demo/base/base_stateful.dart';
import 'package:flutter_application_demo/screens/screens.dart';
import 'package:fluttertoast/fluttertoast.dart';

extension ExtensionsBaseStateful on BaseStateful {
  
  void safePushReplacementNamed(ScreenApp screen, {Map<String, dynamic>? argments}) {
    try{
      Navigator.pushReplacementNamed(context(), screen.key, arguments: argments);
    }catch(e){}
  }

  void safePushNamed(ScreenApp screen, {Map<String, dynamic>? argments}){
    try{
      Navigator.pushNamed(context(), screen.key, arguments: argments);
    }catch(e){}
  }

  Future<void> safePush(
    WidgetBuilder builder
  ) async {
    try{
      await Navigator.push(
        context(), 
        MaterialPageRoute(
          builder: builder
        )
      );
    }catch(e){

    }

    
  }

  void safePushReplacement(WidgetBuilder builder) {
    try{
      Navigator.pushReplacement(context(), MaterialPageRoute(builder: builder));
    }catch(e){}
  }

  void safePop(){
    try{
      Navigator.pop(context());
    }catch(e){}
  }

  void showToast({required String message}){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 16.0
      );
  }
}