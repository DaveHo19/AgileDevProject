import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/models/userInfo.dart';
import 'package:agile_project/scenes/authentication/login/LoginScene.dart';
import 'package:agile_project/scenes/authentication/register/RegisterScene.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/scenes/user/AddressInformation.dart';
import 'package:agile_project/scenes/user/MyOrder.dart';
import 'package:agile_project/scenes/user/ProfileMenu.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:agile_project/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/user/profile_pic.dart';
import 'package:agile_project/scenes/user/UserName.dart';
import 'package:agile_project/scenes/user/ContactNumber.dart';
import 'package:provider/provider.dart';
import 'profile_pic.dart';

class ProfileScene extends StatefulWidget {
  ProfileScene({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScene> createState() => ProfileSceneState();
}

class ProfileSceneState extends State<ProfileScene> {
  AppUser? user;

  UserInfomation? information;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    initialUserInfo();
    return (user == null) ? buildNonUserScene() : buildUserScene();
  }

  Widget buildNonUserScene() {
    return Column(
      children: [
        const ProfilePic(),
        const SizedBox(height: 20),
        ProfileMenu(
            text: "Login",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyLoginScene()));
            },
            icons: const Icon(Icons.login),
            value: ""),
        ProfileMenu(
            text: "Register",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyRegisterScene()));
            },
            icons: const Icon(Icons.app_registration_rounded),
            value: ""),
      ],
    );
  }

  Widget buildUserScene() {
    return FutureBuilder(
      future: initialUserInfo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Loading();
        } else {
          return Column(
            children: [
              ProfilePic(),
              SizedBox(height: 20),
              ProfileMenu(
                text: "Name",
                icons: const Icon(Icons.person),
                value: information!.userName,
                press: () async {
                  bool result = false;
                  result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserNameFieldScene(
                              uid: user!.uid, data: information!.userName)));
                  if (result) {
                    setState(() {});
                  }
                },
              ),
              ProfileMenu(
                text: "Contact Number",
                icons: const Icon(Icons.phone),
                value: information!.phoneNumber ?? "",
                press: () async {
                  bool result = false;
                  result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContactNumberScene(
                              uid: user!.uid,
                              data: information!.phoneNumber ?? "")));
                  if (result) {
                    setState(() {});
                  }
                },
              ),
              ProfileMenu(
                text: "Email Address",
                icons: const Icon(Icons.email),
                value: information!.emailAddress,
                press: () {},
                notDisplayArrow: true,
              ),
              ProfileMenu(
                text: "My Billing Address",
                icons: const Icon(Icons.location_city),
                value: "",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyAddressScene(
                                addressType: AddressType.billing,
                              )));
                },
              ),
              ProfileMenu(
                text: "My Shipping Address",
                icons: const Icon(Icons.location_city),
                value: "",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyAddressScene(
                                addressType: AddressType.shipping,
                              )));
                },
              ),
              ProfileMenu(
                text: "My Order",
                icons: const Icon(Icons.shopping_bag),
                value: "",
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyOrderListScene()));
                },
              ),
              ProfileMenu(
                text: "Logout",
                icons: const Icon(Icons.exit_to_app),
                value: "",
                press: () {
                  AuthService authService = AuthService();
                  authService.signOut();
                },
              ),
            ],
          );
        }
      },
    );
  }

  Future initialUserInfo() async {
    if (user != null) {
      DatabaseService dbService = DatabaseService();
      information = await dbService.getUserInformation(user!.uid);
    }
  }
}
