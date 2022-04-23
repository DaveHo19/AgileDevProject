import 'package:flutter/material.dart';

class MyStockLevelScene extends StatefulWidget{
  const MyStockLevelScene({Key? key}) : super (key: key);

  @override
  State<MyStockLevelScene> createState() => _MyStockLevelSceneState();
}

class _MyStockLevelSceneState extends State<MyStockLevelScene>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Stock Level"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: const SafeArea(
          child: Center(
            child: Text("Stock Level Here")
          ),
        ),
    );
  }
}
