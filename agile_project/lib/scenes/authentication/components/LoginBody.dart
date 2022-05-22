import 'package:flutter/material.dart';
import 'package:agile_project/scenes/authentication/components/LoginBackground.dart';
import 'package:agile_project/components/rounded_input_field.dart';
import 'package:agile_project/components/rounded_password_field.dart';
import 'package:agile_project/components/rounded_button.dart';
//import 'package:flutter_svg/svg.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "LOG IN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // SvgPicture.asset(
          //   'assets/icons/chat.svg',
          //   width: size.width * 0.50,
          // ),
          RoundedInputField(
            hintText: "Your Email",
            onChanged: (value) {},
          ),
          RoundedPasswordField(
            onChanged: (value) {},
          ),
          RoundedButton(
            text: "Login",
            press: () {},
          ),
        ],
      ),
    );
  }
}
