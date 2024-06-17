import 'package:flutter/material.dart';
import 'package:flutter_application_demo/screens/common/loading_state.dart';
import 'package:flutter_application_demo/styles/colors.dart';



class LoaderManager {
  LoaderManager._shareInstance();
  static final LoaderManager _shared = LoaderManager._shareInstance();
  factory LoaderManager.instance() => _shared;

  static LoadingState _state = LoadingState.hide;

  void make(BuildContext context, LoadingState loadingState){
    print("Loading: previus ${_state.name} to ${loadingState.name}");
    try{
      switch(loadingState){
        case LoadingState.hide: _hideLoading(context); break;
        case LoadingState.show: _showLoader(context); break;
        default: break;
      }
    }catch(e){
      
    }
  }


  void _showLoader(BuildContext context) {
    if(LoaderManager._state == LoadingState.hide){
      LoaderManager._state = LoadingState.show;
      showDialog(
        barrierDismissible: false,
        context: context, 
        builder: (_) {
          return const Dialog(
            backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: GColor.primary),
                    SizedBox(height: 20),
                    Text('Cargando...')
                  ],
                ),
              )
          );
        }
      );
    }
  }

  
  void _hideLoading(BuildContext context) {
    if(LoaderManager._state == LoadingState.show){
      LoaderManager._state = LoadingState.hide;
      Navigator.of(context).pop();
    }
  }
}