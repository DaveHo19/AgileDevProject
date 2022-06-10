import 'package:flutter/material.dart';
import 'package:agile_project/scenes/authentication/register/RegisterBody.dart';

class MyRegisterScene extends StatefulWidget{
  const MyRegisterScene({Key? key}) : super (key: key);

  @override
  State<MyRegisterScene> createState() => _MyRegisterSceneState();
}

class _MyRegisterSceneState extends State<MyRegisterScene>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: RegisterBody(),
    );
  }
}