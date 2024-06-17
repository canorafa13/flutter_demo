import 'package:flutter/material.dart';
import 'package:flutter_application_demo/widgets/widgets.dart';

class ZAlertDialog {
  final BuildContext context;
  final String title;
  final String content;
  final VoidCallback? callback;

  const ZAlertDialog(
      {required this.context,
      required this.title,
      required this.content,
      required this.callback});

  void show() {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              ZPrimaryButton(
                text: "Close",
                onPressed: () async {
                  Navigator.of(context).pop();
                  callback?.call();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {}
  }
}
