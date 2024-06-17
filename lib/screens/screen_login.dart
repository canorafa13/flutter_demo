import 'package:flutter_application_demo/base/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_demo/core/models/login_response.dart';
import 'package:flutter_application_demo/core/models/notifiers/on_result.dart';
import 'package:flutter_application_demo/lang/app_strings.dart';
import 'package:flutter_application_demo/screens/common/loading_manager.dart';
import 'package:flutter_application_demo/screens/common/loading_state.dart';
import 'package:flutter_application_demo/screens/common/argument_keys.dart';
import 'package:flutter_application_demo/screens/screens.dart';
import 'package:flutter_application_demo/screens/state/login_state.dart';
import 'package:flutter_application_demo/utils/extensions/extension_base_stateful.dart';
import 'package:flutter_application_demo/utils/extensions/extension_translate_whout_args.dart';
import 'package:flutter_application_demo/widgets/listeners/text_listener.dart';
import 'package:flutter_application_demo/widgets/widgets.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ScreenLogin extends BaseStateful {


  ScreenLogin({super.key});

  final TextListener _user = TextListener();
  final TextListener _password = TextListener();

  LoadingState loading = LoadingState.hide;
  LoginResponse? loginResponse;

  @override
  void addPostCallback(Duration timeStamp, BuildContext context){
    super.addPostCallback(timeStamp, context);
    LoaderManager.instance().make(context, loading);

    if(loginResponse != null){
      safePushReplacementNamed(ScreensApp.home, argments: {
        ArgumentKeys.login.name: loginResponse
      });
    }
  }

  @override
  void dispose(){
    super.dispose();
    _user.controller.dispose();
    _password.controller.dispose();
  }

  @override
  Widget render(BuildContext context){
    final viewModel = Provider.of<LoginState>(context);
    final observer = viewModel.singOnObserver;
    switch(observer){
      case Success():
      loading = LoadingState.hide;
      loginResponse = observer.data;
      break;
      case Error(): 
      loading = LoadingState.hide;
      showToast(message: observer.message);
      break;
      case Loading():  
      loading = LoadingState.show;
      break;
      default: break;
    }
    return BaseScaffold(
      titleBar: AppStrings.TitleLogin.tr(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppStrings.DescriptionLogin.tr(context)),
            ZTextField(
              parameters: ZTextFieldParameters(
                label: AppStrings.User.tr(context),
                listener: _user,
                prefixIcon: Icons.person,
                actionIO: TextInputAction.next
              ),
            ),
            ZTextField(
              parameters: ZTextFieldParameters(
                label: AppStrings.Password.tr(context),
                isSecret: true,
                listener: _password,
                inputType: TextInputType.visiblePassword,
                prefixIcon: Icons.lock_rounded,
                actionIO: TextInputAction.done
              ),
            ),
            ZPrimaryButton(
              text: AppStrings.BtnLogin.tr(context), 
              onPressed: () => Provider.of<LoginState>(context, listen: false).singOn(_user.controller.text, _password.controller.text)
            ),
          ],
        ),
      )
    );
  }
}

