import 'package:flutter/widgets.dart';
import 'package:flutter_application_demo/core/models/notifiers/on_result.dart';

/// Para mapear un map<String, dynamic>
typedef FromMap<T> = T Function(Map<String, dynamic> map);


/// Para resolver una funcion Future
typedef Resolve<T> = void Function(Result<T> result);

typedef WidgetCustom<T> = Widget Function(BuildContext context, T element, int position);

typedef Callback = void Function();