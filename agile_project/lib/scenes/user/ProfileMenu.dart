import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  ProfileMenu({
    Key? key,
    required this.text,
    required this.press,
    required this.icons,
    required this.value,
    this.notDisplayArrow,
    this.longPress,
  }) : super(key: key);

  final String text, value;
  final VoidCallback press;
  VoidCallback? longPress;
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
        onLongPress: longPress ?? () {},
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
          (notDisplayArrow == null)
              ? const Icon(Icons.arrow_forward_ios)
              : Container(),
        ]),
      ),
    );
  }
}
