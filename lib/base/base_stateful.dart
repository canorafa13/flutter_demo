import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_demo/screens/common/argument_keys.dart';


// ignore: must_be_immutable
abstract class BaseStateful extends StatefulWidget {

  BaseStateful({super.key});


  State<BaseStateful>? state;

  void initState(){}

  void dispose(){}

  void didChangeDependencies(){}
  
  @override
  State<BaseStateful> createState() => _BaseStateful();

  void setState(VoidCallback fn) => (state as _BaseStateful).updateState(fn);

  BuildContext context() => (state as _BaseStateful).buildContext();  

  T? args<T>(ArgumentKeys argumentKeys) => (state as _BaseStateful).argments?[argumentKeys.name] as T?;

  Widget renderState(BuildContext context, State<BaseStateful> state){
    if(this.state == null){
      this.state = state;
    }

    return render(context);
  }

  Widget render(BuildContext context);

  void addPostCallbackUnique(Duration timeStamp, BuildContext context){}

  void addPostCallback(Duration timeStamp, BuildContext context){}

  void didChangeAppLifecycleState(AppLifecycleState state){}
}

class _BaseStateful extends State<BaseStateful> with WidgetsBindingObserver  {

  int _render = 0;

  void updateState(VoidCallback fn) => setState(fn);

  BuildContext buildContext() => context;
  
  Map<String, dynamic>? argments;

  @override
  void initState(){
    _render = 0;
    widget.initState();
    super.initState();
  }

  @override
  void dispose(){
    widget.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies();
    // Called when a dependency of the State object changes
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    widget.didChangeAppLifecycleState(state);
  }
  @override
  Widget build(BuildContext context) {
    argments = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?);
    SchedulerBinding.instance.addPostFrameCallback((timings) {
      if(_render == 0){
        widget.addPostCallbackUnique(timings, context);
        _render++;
      }
      widget.addPostCallback(timings, context);
    });

    return widget.renderState(context, this);
  }

}

