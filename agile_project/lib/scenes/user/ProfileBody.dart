import 'package:agile_project/constants.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/models/userInfo.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/scenes/user/AddressInformation.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/user/profile_pic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agile_project/scenes/user/UserName.dart';
import 'package:agile_project/scenes/user/ContactNumber.dart';
import 'package:agile_project/scenes/user/Email.dart';
import 'package:provider/provider.dart';
import 'profile_pic.dart';

class ProfileBody extends StatefulWidget {
  ProfileBody({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileBody> createState() => ProfileBodyState();
}

class ProfileBodyState extends State<ProfileBody> {
  AppUser? user;

  UserInfomation? information = UserInfomation(
      emailAddress: "abc",
      uid: "abc",
      userName: "abc",
      accountLevel: 1,
      phoneNumber: "abc");

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    initialUserInfo();
    return FutureBuilder(
      future: initialUserInfo(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Loading();
        } else {
          return buildContent();
        }
      },
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20),
        ProfileMenu(
          icon: "icons/usericon.png",
          text: "Name",
          icons: const Icon(Icons.person),
          value: information!.userName,
          press: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserNameFieldScene(
                        uid: user!.uid, data: information!.userName)));
          },
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "Contact Number",
          icons: const Icon(Icons.phone),
          value: information!.phoneNumber ?? "",
          press: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContactNumberScene(
                        uid: user!.uid, data: information!.phoneNumber ?? "")));
          },
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "Email Address",
          icons: const Icon(Icons.email),
          value: information!.emailAddress,
          press: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => EmailScene()));
          },
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "My Address",
          icons: const Icon(Icons.location_city),
          value: "",
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyAddressScene()));
          },
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "My Order",
          icons: const Icon(Icons.shopping_bag),
          value: "",
          press: () {},
          // press: () {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => ContactNumberScene()));
          // },
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "Logout",
          icons: const Icon(Icons.exit_to_app),
          value: "",
          press: () {},
          // press: () {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => ContactNumberScene()));
          // },
        ),
        ElevatedButton(onPressed: () {}, child: Text("Test")),
      ],
    );
  }

  Future initialUserInfo() async {
    if (user != null) {
      DatabaseService dbService = DatabaseService();
      information = await dbService.getUserInformation(user!.uid);
      print(information!.userName);
      print(information!.emailAddress);
    }
  }
}

class ProfileMenu extends StatelessWidget {
  ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
    required this.icons,
    required this.value,
  }) : super(key: key);

  final String text, icon, value;
  final VoidCallback press;
  final Icon icons;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF5F6F9),
        onPressed: press,
        child: Row(children: [
          // SvgPicture.asset(
          //   icon,
          //   width: 22,
          //   color: kPrimaryColor,
          // ),
          icons,
          SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Icon(Icons.arrow_forward_ios)
        ]),
      ),
    );
  }
}
