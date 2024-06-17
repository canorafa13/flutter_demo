import 'package:flutter/widgets.dart';
import 'package:flutter_application_demo/utils/app_typedef.dart';

class ZList<T> extends StatelessWidget {
  final List<T> items;
  final WidgetCustom<T> widget;
  const ZList({super.key, required this.items, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            //physics: const NeverScrollableScrollPhysics(),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) =>
                widget(context, items[index], index)));
  }
}
