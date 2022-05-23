import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/authentication/login/LoginScene.dart';
import 'package:agile_project/scenes/authentication/register/RegisterScene.dart';
import 'package:agile_project/services/firebase_auth.dart';
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
    return (user == null) ? _buildIn() : _buildOut();
  }

  Widget _buildIn(){
    return Center(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            ElevatedButton(
              child: const Text("Login"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyLoginScene()));
              }),
            const SizedBox(height: 20,),
             ElevatedButton(
              child: const Text("Register"),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyRegisterScene()));
              } ),
        ],),
    );
  } 
  Widget _buildOut(){
    return Container(
      child: Center(
        child: ElevatedButton(
          child: const Text("Logout"),
          onPressed: (){
            AuthService().signOut();
          },
        )
      )
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
