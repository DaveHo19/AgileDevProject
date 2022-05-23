import 'package:agile_project/models/user.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:provider/provider.dart';

class MyHomeScene extends StatefulWidget{
  const MyHomeScene({
    Key? key,
    }) : super (key: key);

  @override
  State<MyHomeScene> createState() => _MyHomeSceneState();
}

class _MyHomeSceneState extends State<MyHomeScene>{

  var user;
  AccountType currAccountType = AccountType.guest;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //for identify login or not 
    user = Provider.of<AppUser?>(context);
    isAdmin();
    return Center(
      child:  (currAccountType == AccountType.guest) ? 
              const Text("Guest Home View") : 
              (currAccountType == AccountType.user) ? 
              const Text("User Home View") :
              (currAccountType == AccountType.admin) ?
              const Text("Admin Home View") : const Text("ERROR: Account Type Out of Bonud"),
      );
  }

    void isAdmin(){
     
     if (user != null){
      if (user.uid == "AJDG4Ze3wpdav5bThoGHMfCekmI2"){
        currAccountType = AccountType.admin;
     } else {
       currAccountType = AccountType.user;
      } 
     } else {
       currAccountType = AccountType.guest;
     }
  }
}
