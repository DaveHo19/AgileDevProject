import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/models/userInfo.dart';
import 'package:agile_project/scenes/authentication/login/LoginScene.dart';
import 'package:agile_project/scenes/authentication/register/RegisterScene.dart';
import 'package:agile_project/scenes/user/InformationScene.dart';
import 'package:agile_project/services/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agile_project/constants.dart';

class MyProfileScene extends StatefulWidget {
  const MyProfileScene({
    Key? key,
  }) : super(key: key);

  @override
  State<MyProfileScene> createState() => _MyProfileSceneState();
}

class _MyProfileSceneState extends State<MyProfileScene> {
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

  Widget _buildIn() {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              child: const Text("Login"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyLoginScene()));
              }),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              child: const Text("Register"),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyRegisterScene()));
              }),
        ],
      ),
    );
  }

  // Widget _buildOut(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //     child: FlatButton(
  //       padding: EdgeInsets.all(20),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //       color: Color(0xFFF5F6F9),
  //       onPressed: () {},
  //       child: Row(
  //         children: [
  //           SvgPicture.asset(
  //             "icons/usericon.svg",
  //             width: 22,
  //             color: kPrimaryColor,
  //           ),
  //           SizedBox(width: 20),
  //           Expanded(
  //             child: Text(
  //               "My Account",
  //               style: Theme.of(context).textTheme.bodyText1,
  //             ),
  //           ),
  //           Icon(Icons.arrow_forward_ios)
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildOut() {
    return Center(
        child: Column(children: [
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
          child: const Text("My Information"),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyInformationScene()));
          }),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
          child: const Text("My Address"),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyRegisterScene()));
          }),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
          child: const Text("My Order"),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyRegisterScene()));
          }),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
        child: const Text("Logout"),
        onPressed: () {
          AuthService().signOut();
        },
      )
    ] //children
            ));
  }

  void isAdmin() {
    if (user != null) {
      if (user.uid == "AJDG4Ze3wpdav5bThoGHMfCekmI2") {
        currAccountType = AccountType.admin;
      } else {
        currAccountType = AccountType.user;
      }
    } else {
      currAccountType = AccountType.guest;
    }
  }
}
