import 'package:flutter/material.dart';

class MyManageProductScene extends StatefulWidget{
  const MyManageProductScene({Key? key}) : super (key: key);

  @override
  State<MyManageProductScene> createState() => _MyManageProductSceneState();
}

class _MyManageProductSceneState extends State<MyManageProductScene>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Manage Product"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: const SafeArea(
          child: Center(
            child: Text("Manage Product Here")
          ),
        ),
    );
  }
}
