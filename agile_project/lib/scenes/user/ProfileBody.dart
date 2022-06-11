import 'package:agile_project/constants.dart';
import 'package:agile_project/scenes/user/AddressInformation.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/user/profile_pic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agile_project/scenes/user/UserName.dart';
import 'package:agile_project/scenes/user/ContactNumber.dart';
import 'package:agile_project/scenes/user/Email.dart';
import 'profile_pic.dart';

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20),
        ProfileMenu(
          icon: "icons/usericon.png",
          text: "Name",
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => UserNameScene()));
          },
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "Contact Number",
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactNumberScene()));
          },
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "Email Address",
          press: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => EmailScene()));
          },
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "My Address",
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyAddressScene()));
          },
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "My Order",
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactNumberScene()));
          },
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "Logout",
          press: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactNumberScene()));
          },
        ),
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

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
          SvgPicture.asset(
            icon,
            width: 22,
            color: kPrimaryColor,
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Icon(Icons.arrow_forward_ios)
        ]),
      ),
    );
  }
}
