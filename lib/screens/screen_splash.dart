import 'package:flutter/material.dart';
import 'package:flutter_application_demo/base/base_stateful.dart';
import 'package:flutter_application_demo/lang/app_strings.dart';
import 'package:flutter_application_demo/screens/screens.dart';
import 'package:flutter_application_demo/styles/colors.dart';
import 'dart:async';
import 'package:flutter_application_demo/utils/extensions/extension_base_stateful.dart';
import 'package:flutter_application_demo/utils/extensions/extension_translate_whout_args.dart';

// ignore: must_be_immutable
class ScreenSplash extends BaseStateful {
  ScreenSplash({super.key});

  Timer? _timer;
  int _start = 5;
  
  @override
  void initState(){
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
  }

  

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1), 
      (Timer timer) {
        if (_start == 0) {
          safePushReplacementNamed(ScreensApp.login);
        } else {
          setState(() => _start--);
        }
      },
    );
  }

  @override
  Widget render(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: GColor.white,
              backgroundColor: GColor.primary,
            ),
            Text(
              AppStrings.LoadingProgress.trWithArg(context, {"progress": "$_start"}),
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                color: GColor.white
              ),
            )
          ],
        ),
      ),
      backgroundColor: GColor.primary,
    );
  }

}