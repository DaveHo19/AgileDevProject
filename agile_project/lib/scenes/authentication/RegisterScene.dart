import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/authentication/components/RegisterBody.dart';

class MyRegisterScene extends StatefulWidget {
  const MyRegisterScene({Key? key}) : super(key: key);

  @override
  State<MyRegisterScene> createState() => _MyRegisterSceneState();
}

class _MyRegisterSceneState extends State<MyRegisterScene> {
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
      body: const Body(),
      // const SafeArea(
      //   child: Center(
      //     child: Text("register"),
      //   ),
      // ),
    );
  }
}
