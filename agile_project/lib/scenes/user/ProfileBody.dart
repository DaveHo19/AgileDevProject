<<<<<<< Updated upstream
import 'dart:html';
import 'package:agile_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/user/profile_pic.dart';
import 'package:flutter_svg/flutter_svg.dart';
=======
import 'package:agile_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agile_project/scenes/user/UserName.dart';

import 'profile_pic.dart';
>>>>>>> Stashed changes

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20),
<<<<<<< Updated upstream
        ProfileMenu(),
=======
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
          press: () {},
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "Email Address",
          press: () {},
        ),
>>>>>>> Stashed changes
      ],
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
<<<<<<< Updated upstream
  }) : super(key: key);

=======
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFFF5F6F9),
<<<<<<< Updated upstream
        onPressed: () {},
        child: Row(
          children: [
            SvgPicture.asset(
              "icons/usericon.svg",
              width: 22,
              color: kPrimaryColor,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                "My Account",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
=======
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
>>>>>>> Stashed changes
      ),
    );
  }
}
