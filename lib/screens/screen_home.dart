import 'package:flutter/material.dart';
import 'package:flutter_application_demo/base/base_scaffold.dart';
import 'package:flutter_application_demo/base/base_stateful.dart';
import 'package:flutter_application_demo/core/models/dog.dart';
import 'package:flutter_application_demo/core/models/login_response.dart';
import 'package:flutter_application_demo/lang/app_strings.dart';
import 'package:flutter_application_demo/screens/common/loading_state.dart';
import 'package:flutter_application_demo/screens/common/argument_keys.dart';
import 'package:flutter_application_demo/screens/screen_dog/screen_crud_dog.dart';
import 'package:flutter_application_demo/screens/state/dog_state.dart';
import 'package:flutter_application_demo/utils/extensions/extension_base_stateful.dart';
import 'package:flutter_application_demo/utils/extensions/extension_translate_whout_args.dart';
import 'package:flutter_application_demo/widgets/z_container_if.dart';
import 'package:flutter_application_demo/widgets/z_list.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ScreenHome extends BaseStateful {
  ScreenHome({super.key});

  LoadingState loading = LoadingState.show;

  bool isRefresh = false;

  @override
  void addPostCallback(Duration timeStamp, BuildContext context) {
    super.addPostCallback(timeStamp, context);
    if (isRefresh) {
      final viewModel = Provider.of<DogState>(context, listen: false);
      viewModel.findAllDogs();
    }
  }

  @override
  void addPostCallbackUnique(Duration timeStamp, BuildContext context) {
    super.addPostCallbackUnique(timeStamp, context);
    final viewModel = Provider.of<DogState>(context, listen: false);
    viewModel.findAllDogs();
  }

  @override
  Widget render(BuildContext context) {
    final viewModel = Provider.of<DogState>(context);
    loading = viewModel.loading;
    List<Dog> dogList = viewModel.listDogsObserver;
    String? messageError = viewModel.error;
    if (messageError != null) {
      showToast(message: messageError);
    }

    isRefresh = viewModel.refreshListObserver;

    final loginResponse = args<LoginResponse>(ArgumentKeys.login);

    return BaseScaffold(
      titleBar: AppStrings.TitleHome.tr(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(loginResponse?.name ?? "Nombre random"),
          loading == LoadingState.show
              ? _ShimerListHome()
              : ZContainerIf(
                  condition: dogList.isNotEmpty,
                  widgetTrue: ZList(
                      items: dogList,
                      widget: (context, item, position) => InkWell(
                            child: Card(
                              margin: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Text("Nombre: ${item.name}"),
                                  Text("Edad: ${item.age}"),
                                  const Divider(),
                                  Text(
                                      "Fecha de creación: ${item.createAt?.value}"),
                                  Container(
                                      child: item.updateAt != null
                                          ? Text(
                                              "Fecha de actualización: ${item.updateAt?.value}")
                                          : const SizedBox.shrink())
                                ],
                              ),
                            ),
                            onTap: () async {
                              await safePush((context) => ScreenCRUDDog(
                                    id: item.id,
                                  ));
                            },
                          )))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        tooltip: 'Add',
        onPressed: () async {
          await safePush((context) => ScreenCRUDDog(id: null));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}

class _ShimerListHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
              child: SizedBox(height: 100, width: double.maxFinite,),
            ),
            Card(
              child: SizedBox(height: 100, width: double.maxFinite,),
            ),
            Card(
              child: SizedBox(height: 100, width: double.maxFinite,),
            ),
            Card(
              child: SizedBox(height: 100, width: double.maxFinite,),
            ),
            Card(
              child: SizedBox(height: 100, width: double.maxFinite,),
            )
          ],
        ),
      ),
    );
  }
}
