import 'package:flutter/material.dart';
import 'package:agile_project/scenes/authentication/components/LoginBody.dart';

class MyLoginScene extends StatefulWidget {
  const MyLoginScene({Key? key}) : super(key: key);

  @override
  State<MyLoginScene> createState() => _MyLoginSceneState();
}

class _MyLoginSceneState extends State<MyLoginScene> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Login(),

      // const SafeArea(
      // child: Center(
      //   child: Text("Login Scene Here")
      // ),
      // ),
    );
  }
}
