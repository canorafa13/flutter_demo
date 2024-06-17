import 'package:flutter/material.dart';
import 'package:flutter_application_demo/core/models/login_response.dart';
import 'package:flutter_application_demo/core/models/notifiers/on_result.dart';
import 'package:flutter_application_demo/core/repositories/login_repository.dart';

class LoginState with ChangeNotifier{
  final _loginRespository = LoginRespository();

  Result<LoginResponse> singOnObserver = Result.none();

  void singOn(String user, String password) =>
    _loginRespository.singOn(user, password, (result) { 
      singOnObserver = result;
      notifyListeners();
    });

}