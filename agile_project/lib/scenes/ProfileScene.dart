import 'package:flutter/material.dart';

class MyProfileScene extends StatefulWidget{
  const MyProfileScene({Key? key}) : super (key: key);

  @override
  State<MyProfileScene> createState() => _MyProfileSceneState();
}

class _MyProfileSceneState extends State<MyProfileScene>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Profile Scene"),);
  }
}
