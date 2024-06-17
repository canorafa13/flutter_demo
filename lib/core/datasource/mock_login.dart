import 'package:flutter_application_demo/core/models/login_response.dart';
import 'package:flutter_application_demo/core/models/notifiers/on_result.dart';
import 'package:flutter_application_demo/utils/app_typedef.dart';

class MockLogin{
  void singOn(String user, String password, Resolve<LoginResponse> resolve) async{
    resolve.call(Result.loading());
    await Future.delayed(const Duration(seconds: 3));
    if(user != "rcano"){
      resolve.call(Result.error("Usuario incorrecto"));
      return;
    }

    if(password != "1234"){
      resolve.call(Result.error("Contraseña incorrecta"));
      return;
    }

    resolve.call(Result.success(const LoginResponse(id: 1212, name: "Rafael Cano", age: 27))); 
  }
}