import 'package:flutter/material.dart';

class MyWishlistScene extends StatefulWidget{
  const MyWishlistScene({Key? key}) : super (key: key);

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
    return const Center(child: Text("Wishlist Scene"),);
  }
}
