import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:flutter/material.dart';

class EditNewAddressBody extends StatelessWidget {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              decoration: inputDecoration("New Address"),
              minLines: 5,
              maxLines: 10,
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
