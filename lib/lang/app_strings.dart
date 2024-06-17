// ignore_for_file: constant_identifier_names

enum AppStrings{
  FlutterDemo(value: "title_main"),
  TitleLogin(value: "title_login"),
  TitleHome(value: "title_home"),
  User(value: "user"),
  Password(value: "password"),
  HelloPerson(value: "hello_person"),
  LoadingProgress(value: "loading_progress"),
  DescriptionLogin(value: "description_login"),
  BtnLogin(value: "btn_login");

  final String value;
  const AppStrings({required this.value});
}

