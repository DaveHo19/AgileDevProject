import 'package:flutter/material.dart';
import 'package:agile_project/scenes/user/ProfileBody.dart';

class MyInformationScene extends StatefulWidget {
  const MyInformationScene({Key? key}) : super(key: key);

  @override
  State<MyInformationScene> createState() => _MyInformationSceneState();
}

class _MyInformationSceneState extends State<MyInformationScene> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Information"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: ProfileBody(),
    );
  }
}
