import 'package:flutter/material.dart';

class MyViewProductScene extends StatefulWidget{
  const MyViewProductScene({Key? key}) : super (key: key);

  @override
  State<MyViewProductScene> createState() => _MyViewProductSceneState();
}

class _MyViewProductSceneState extends State<MyViewProductScene>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("View Product"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: const SafeArea(
          child: Center(
            child: Text("View Product Here")
          ),
        ),
    );
  }
}
