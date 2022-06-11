import 'package:agile_project/models/user.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:provider/provider.dart';

class MyWishlistScene extends StatefulWidget {
  const MyWishlistScene({
    Key? key,
  }) : super(key: key);

  @override
  State<MyWishlistScene> createState() => _MyWishlistSceneState();
}

class _MyWishlistSceneState extends State<MyWishlistScene> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //for identify login or not
    AccountType currAccountType = (Provider.of<AppUser?>(context) == null)
        ? AccountType.guest
        : AccountType.admin;

    return const Center(
      child: Text("This scene will be implement in future!"),
    );
  }
}
