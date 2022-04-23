import 'package:flutter/material.dart';
import 'package:agile_project/components/_enumList.dart';

class MyHomeScene extends StatefulWidget{
  const MyHomeScene({
    Key? key,
    required this.currAccountType,
    }) : super (key: key);

  final AccountType currAccountType;
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
    return Center(
      child:  (widget.currAccountType == AccountType.guest) ? 
              const Text("Guest Home View") : 
              (widget.currAccountType == AccountType.user) ? 
              const Text("User Home View") :
              (widget.currAccountType == AccountType.admin) ?
              const Text("Admin Home View") : const Text("ERROR: Account Type Out of Bonud"),
      );
  }
}
