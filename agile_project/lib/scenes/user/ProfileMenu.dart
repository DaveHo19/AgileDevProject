import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  ProfileMenu({
    Key? key,
    required this.text,
    //required this.icon,
    required this.press,
    required this.icons,
    required this.value,
    this.notDisplayArrow,
  }) : super(key: key);

  final String text, value;
  //final String icon;
  final VoidCallback press;
  final Icon icons;
  bool? notDisplayArrow;

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
          icons,
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          (notDisplayArrow == null) ? const Icon(Icons.arrow_forward_ios) : Container(),
        ]),
      ),
    );
  }
}