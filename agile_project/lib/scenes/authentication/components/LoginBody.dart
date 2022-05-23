import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/models/rounded_input_field.dart';
import 'package:agile_project/models/rounded_password_field.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/authentication/components/LoginBackground.dart';


class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "LOG IN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
