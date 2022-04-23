import 'package:flutter/material.dart';
import 'package:agile_project/components/_enumList.dart';

class MyWishlistScene extends StatefulWidget{
  const MyWishlistScene({
    Key? key, 
    required this.currAccountType
    }) : super (key: key);

  final AccountType currAccountType;
  @override
  State<MyWishlistScene> createState() => _MyWishlistSceneState();
}

class _MyWishlistSceneState extends State<MyWishlistScene>{

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
        return Center(
      child:  (widget.currAccountType == AccountType.guest) ? 
              const Text("Guest Wishlist View") : 
              (widget.currAccountType == AccountType.user) ? 
              const Text("User Wishlist View") :
              (widget.currAccountType == AccountType.admin) ?
              const Text("Admin Wishlist View") : const Text("ERROR: Account Type Out of Bonud"),
      );
  }
}
