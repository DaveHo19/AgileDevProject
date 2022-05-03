import 'package:agile_project/models/user.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:provider/provider.dart';

class MyWishlistScene extends StatefulWidget{
  const MyWishlistScene({
    Key? key, 
    }) : super (key: key);

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
    //for identify login or not 
    AccountType currAccountType = (Provider.of<AppUser?>(context) == null) ? AccountType.guest : AccountType.admin; 

    return Center(
      child:  (currAccountType == AccountType.guest) ? 
              const Text("Guest Wishlist View") : 
              (currAccountType == AccountType.user) ? 
              const Text("User Wishlist View") :
              (currAccountType == AccountType.admin) ?
              const Text("Admin Wishlist View") : const Text("ERROR: Account Type Out of Bonud"),
      );
  }
}
