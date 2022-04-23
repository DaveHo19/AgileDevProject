import 'package:agile_project/components/_enumList.dart';
import 'package:flutter/material.dart';

class MyProfileScene extends StatefulWidget{
  const MyProfileScene({
    Key? key, 
    required this.currAccountType
    }) : super (key: key); 

  final AccountType currAccountType;
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
    return Center(
      child:  (widget.currAccountType == AccountType.guest) ? 
              const Text("Guest Profile View") : 
              (widget.currAccountType == AccountType.user) ? 
              const Text("User Profile View") :
              (widget.currAccountType == AccountType.admin) ?
              const Text("Admin Profile View") : const Text("ERROR: Account Type Out of Bonud"),
      );
  }
}
