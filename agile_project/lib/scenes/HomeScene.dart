import 'package:flutter/material.dart';

class MyHomeScene extends StatefulWidget{
  const MyHomeScene({Key? key}) : super (key: key);

  @override
  State<MyHomeScene> createState() => _MyHomeSceneState();
}

class _MyHomeSceneState extends State<MyHomeScene>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Home Scene"),);
  }
}
