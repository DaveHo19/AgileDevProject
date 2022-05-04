import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
        body: const SafeArea(
          child: Center(
            child: Text("register"),
          ),
        ),
    );
  }
}
