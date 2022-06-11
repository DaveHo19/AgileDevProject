import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:agile_project/scenes/user/UserName.dart';
import 'package:agile_project/scenes/user/ProfileBody.dart';

class EditContactNumberBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(

        // NameMenu(
        //   text: "Input your username here",
        //   press: () {},
        //   ),
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
