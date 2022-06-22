import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agile_project/scenes/user/UserName.dart';
import 'package:agile_project/scenes/user/ProfileBody.dart';

class EditContactNumberBody extends StatelessWidget {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              decoration: inputDecoration("Contact Number"),
            ),
          ),
          RoundedButton(
            text: "Save",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class NameMenu extends StatelessWidget {
  const NameMenu({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
