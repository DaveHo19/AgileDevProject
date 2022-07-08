import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [ProfilePic()],
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        width: 120,
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: const CircleAvatar(
              backgroundImage: AssetImage("images/profilepic.png"),
            )));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SizedBox(
  //     height: 110,
  //     width: 110,
  //     child: Stack(
  //       fit: StackFit.expand,
  //       children: [
  //         const CircleAvatar(
  //           radius: 50,
  //           backgroundImage: AssetImage("images/profilepic.png"),
  //         ),
  //         // Positioned(
  //         //   right: -12,
  //         //   bottom: 0,
  //         //   child: SizedBox(
  //         //     height: 46,
  //         //     width: 46,
  //         //     child: FlatButton(
  //         //       padding: EdgeInsets.zero,
  //         //       shape: RoundedRectangleBorder(
  //         //         borderRadius: BorderRadius.circular(50),
  //         //         side: BorderSide(color: Colors.white),
  //         //       ),
  //         //       color: Color(0xFFF5F6F9),
  //         //       onPressed: () {},
  //         //       child: SvgPicture.asset("images/profilepic.png"),
  //         //     ),
  //         //   ),
  //         // )
  //       ],
  //     ),
  //   );
  // }
}
