import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/models/rounded_input_field.dart';
import 'package:agile_project/models/rounded_password_field.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/authentication/login/LoginBackground.dart';
import 'package:agile_project/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String psw = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? const Loading()
        : Background(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "LOG IN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                RoundedInputField(
                  hintText: "Your Email",
                  onChanged: (value) {
                    email = value;
                  },
                ),
                RoundedPasswordField(
                  onChanged: (value) {
                    psw = value;
                  },
                ),
                RoundedButton(
                  text: "Login",
                  press: login,
                ),
              ],
            ),
          );
  }

//email and password are required for login
//error message will prompt for unverified login
  void login() async {
    if (isFilledAll(email, psw)) {
      if (validateEmail(email)) {
        setState(() {
          isLoading = true;
        });
        AuthService authService = AuthService();
        dynamic result =
            await authService.signInWithEmailAndPassword(email, psw);
        if (result != null) {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login successfully!!")));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const MyApp()));
        } else {
          setState(() {
            isLoading = false;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Failed to login with the email and password")));
          });
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

  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool isFilledAll(String email, String psw) {
    return ((email.isNotEmpty) && (psw.isNotEmpty));
  }
}
