import 'package:flutter_application_demo/core/datasource/mock_login.dart';
import 'package:flutter_application_demo/core/models/login_response.dart';
import 'package:flutter_application_demo/utils/app_typedef.dart';

class LoginRespository{
  final MockLogin _mockLogin = MockLogin();
  singOn(String user, String password, Resolve<LoginResponse> resolve) =>
    _mockLogin.singOn(user, password, resolve);

  
}