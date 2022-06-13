import 'package:flutter/material.dart';
import "package:agile_project/models/enumList.dart";

class MyHomeScene extends StatefulWidget {
  const MyHomeScene({
    Key? key,
    required this.currAccountType,
  }) : super(key: key);

  final AccountType currAccountType;
  @override
  State<MyHomeScene> createState() => _MyHomeSceneState();
}

class _MyHomeSceneState extends State<MyHomeScene> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
