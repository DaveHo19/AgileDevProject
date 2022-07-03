import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/models/rounded_input_field.dart';
import 'package:agile_project/models/rounded_password_field.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/authentication/register/RegisterBackground.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterBody extends StatefulWidget {
  RegisterBody({Key? key}) : super(key: key);

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  String email = "";

  String psdOne = "";

  String psdTwo = "";

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Background(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "SIGN UP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SvgPicture.asset('assets/icons/chat.svg'),
                RoundedInputField(
                  hintText: "Your Email",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    psdOne = value;
                  },
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    psdTwo = value;
                  },
                ),
                RoundedButton(
                  text: "SIGN UP",
                  press: registerEvent,
                ),
              ],
            ),
          );
  }

//Implement Firebase database service to store data
  void registerEvent() async {
    if (isFilledAll(email, psdOne, psdTwo)) {
      if (validateEmail(email)) {
        if (psdOne == psdTwo) {
          setState(() {
            isLoading = true;
          });
          AuthService authService = AuthService();
          dynamic result =
              await authService.registerWithEmailAndPassword(email, psdOne);
          if (result != null) {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Register successfully!!")));
            Navigator.pop(context);
          }

          //Prompt error message for invalid input
          else {
            setState(() {
              isLoading = false;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text("Failed to register with the email and password")));
            });
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Both password are differences!")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid format for email address!")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("There are some field is empty!")));
    }
  }

//valid format for email
  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

//email and password should not be empty
  bool isFilledAll(String email, String psdOne, String psdTwo) {
    return ((email.isNotEmpty) && (psdOne.isNotEmpty) && (psdTwo.isNotEmpty));
  }
}
