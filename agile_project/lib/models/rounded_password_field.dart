import 'package:flutter/material.dart';
import 'package:agile_project/components/text_field_container.dart';
import 'package:agile_project/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor ,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor ,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor ,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}