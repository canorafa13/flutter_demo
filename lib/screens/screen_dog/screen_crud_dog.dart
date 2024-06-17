import 'package:flutter/material.dart';
import 'package:flutter_application_demo/base/base_scaffold.dart';
import 'package:flutter_application_demo/base/base_stateful.dart';
import 'package:flutter_application_demo/core/models/dog.dart';
import 'package:flutter_application_demo/screens/common/alert_dialog.dart';
import 'package:flutter_application_demo/screens/common/loading_manager.dart';
import 'package:flutter_application_demo/screens/common/loading_state.dart';
import 'package:flutter_application_demo/screens/state/dog_state.dart';
import 'package:flutter_application_demo/utils/extensions/extension_base_stateful.dart';
import 'package:flutter_application_demo/widgets/listeners/text_listener.dart';
import 'package:flutter_application_demo/widgets/z_container_if.dart';
import 'package:flutter_application_demo/widgets/z_primary_button.dart';
import 'package:flutter_application_demo/widgets/z_text_field.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ScreenCRUDDog extends BaseStateful {
  final TextListener _idListener = TextListener();
  final TextListener _nameListener = TextListener();
  final TextListener _ageListener = TextListener();
  final TextListener _createListener = TextListener();
  final TextListener _updateListener = TextListener();

  LoadingState loading = LoadingState.hide;

  final int? _id;

  Dog? dog;

  ScreenCRUDDog({super.key, int? id}) : _id = id;

  bool afeterUpdate = false;

  bool refreshList = false;

  @override
  void addPostCallback(Duration timeStamp, BuildContext context) {
    super.addPostCallback(timeStamp, context);
    LoaderManager.instance().make(context, refreshList ? LoadingState.hide : loading);
    if (afeterUpdate) {
      afeterUpdate = false;
      final viewModel = Provider.of<DogState>(context, listen: false);
      viewModel.refreshListAfterUpdate();
      LoaderManager.instance().make(context, LoadingState.hide);
      ZAlertDialog(
          context: context,
          title: "Completado",
          content: "Actualización completada",
          callback: () {
            safePop();
          }).show();
    }
    
  }

  @override
  void addPostCallbackUnique(Duration timeStamp, BuildContext context) {
    super.addPostCallbackUnique(timeStamp, context);
    if (_id != null) {
      final viewModel = Provider.of<DogState>(context, listen: false);
      viewModel.findOneDog(_id!);
    }
  }

  @override
  void dispose() {
    _idListener.controller.dispose();
    _nameListener.controller.dispose();
    _ageListener.controller.dispose();
    _createListener.controller.dispose();
    _updateListener.controller.dispose();
    super.dispose();
  }

  @override
  Widget render(BuildContext context) {
    final viewModel = Provider.of<DogState>(context);

    loading = viewModel.loading;
    final error = viewModel.error;
    if (error != null) {
      showToast(message: error);
    }

    final numberUpdates = viewModel.updateDogObserver;
    final idCreated = viewModel.createDogObserver;
    final numberDeletes = viewModel.deleteDogObserver;

    if (_id != null) {
      dog = viewModel.dogObserver;
      if (numberUpdates != null && numberUpdates > 0) {
        afeterUpdate = true;
      }

      if (numberDeletes != null && numberDeletes > 0) {
        afeterUpdate = true;
      }
    } else {
      if (idCreated != null && idCreated > 0) {
        afeterUpdate = true;
      }
    }

    if (dog != null) {
      _idListener.controller.value = TextEditingValue(text: dog!.id.toString());
      _nameListener.controller.value = TextEditingValue(text: dog!.name);
      _ageListener.controller.value =
          TextEditingValue(text: dog!.age.toString());
      _createListener.controller.value =
          TextEditingValue(text: dog!.createAt?.value ?? '');
      _updateListener.controller.value =
          TextEditingValue(text: dog!.updateAt?.value ?? '');
    }

    refreshList = viewModel.refreshListObserver;

    return BaseScaffold(
        titleBar: _id == null ? "Crear" : "Actualizar",
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZContainerIf(
                  widgetTrue: ZTextField(
                    parameters: ZTextFieldParameters(
                        label: "ID",
                        readOnly: true,
                        prefixIcon: Icons.numbers,
                        listener: _idListener),
                  ),
                  condition: _id != null),
              ZTextField(
                parameters: ZTextFieldParameters(
                    label: "Nombre",
                    listener: _nameListener,
                    prefixIcon: Icons.abc,
                    actionIO: TextInputAction.next),
              ),
              ZTextField(
                parameters: ZTextFieldParameters(
                    label: "Edad",
                    listener: _ageListener,
                    inputType: TextInputType.number,
                    prefixIcon: Icons.numbers,
                    actionIO: TextInputAction.done),
              ),
              ZContainerIf(
                  widgetTrue: ZTextField(
                    parameters: ZTextFieldParameters(
                        label: "Fecha creación",
                        readOnly: true,
                        listener: _createListener,
                        prefixIcon: Icons.calendar_month),
                  ),
                  condition: _id != null),
              ZContainerIf(
                  widgetTrue: ZTextField(
                    parameters: ZTextFieldParameters(
                        label: "Fecha actualización",
                        readOnly: true,
                        listener: _updateListener,
                        prefixIcon: Icons.calendar_month),
                  ),
                  condition: dog?.updateAt != null),
              ZPrimaryButton(
                  text: "Guardar",
                  onPressed: () {
                    print("OnPreess Guardar");
                    if (_id == null) {
                      Provider.of<DogState>(context, listen: false).createDog(
                          Dog.from(
                              _nameListener.controller.text,
                              int.tryParse(_ageListener.controller.text) ??
                                  -1));
                    } else if (dog != null) {
                      dog?.name = _nameListener.controller.text;
                      dog?.age = int.tryParse(_ageListener.controller.text) ??
                          dog?.age ??
                          0;
                      Provider.of<DogState>(context, listen: false)
                          .updateDog(dog!);
                    }
                  }),
              const SizedBox.square(
                dimension: 20,
              ),
              ZContainerIf(
                  condition: _id != null,
                  widgetTrue: GestureDetector(
                      onTap: () {
                        Provider.of<DogState>(context, listen: false)
                            .deleteDog(_id ?? 0);
                      },
                      child: const Text("Eliminar")))
            ],
          ),
        ));
  }
}
