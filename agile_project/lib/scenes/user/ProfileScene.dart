import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProfileScene extends StatefulWidget{
  const MyProfileScene({
    Key? key, 
    }) : super (key: key); 

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
    //for identify login or not 
    AccountType currAccountType = (Provider.of<AppUser?>(context) == null) ? AccountType.guest : AccountType.admin; 
    return Center(
      child:  (currAccountType == AccountType.guest) ? 
              const Text("Guest Profile View") : 
              (currAccountType == AccountType.user) ? 
              const Text("User Profile View") :
              (currAccountType == AccountType.admin) ?
              const Text("Admin Profile View") : const Text("ERROR: Account Type Out of Bonud"),
      );
  }
}
