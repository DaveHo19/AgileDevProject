import 'package:agile_project/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//import 'profile_pic.dart';

class AddressBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //ProfilePic(),
        SizedBox(height: 20),
        ProfileMenu(
          icon: "icons/usericon.png",
          text: "Address 1",
          press: () {},
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "Address 2",
          press: () {},
        ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "Address 3",
          press: () {},
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
