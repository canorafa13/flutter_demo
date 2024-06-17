import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BaseScaffold extends StatelessWidget {

 
  BaseScaffold({super.key, required this.titleBar, required this.body, this.floatingActionButton});

  final String titleBar;

  final Widget body;

  Widget? floatingActionButton;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(titleBar),
      ),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}

