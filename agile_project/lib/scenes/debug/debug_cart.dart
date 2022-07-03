import 'package:agile_project/models/cartItem.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/services/databaseService.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class DebugCarts extends StatefulWidget {
  const DebugCarts({Key? key}) : super(key: key);

  @override
  State<DebugCarts> createState() => _DebugCartsState();
}

class _DebugCartsState extends State<DebugCarts> {
  AppUser? user;
  final DatabaseService dbService = DatabaseService();
  Map<String, int> cartItems = {};
  List<CartItem> cartList = [];
  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    getCart();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Debug Cart"),
      actions: [
        IconButton(
          onPressed: () async {
            getCart();
            setState(() {
            });
            }, 
          icon: const Icon(Icons.refresh))
      ],
      ),
      body: ListView.builder(
        itemCount: cartList.length,
        itemBuilder: (context, i) {
          return buildrow(cartList[i].bookID, cartList[i].quantity, i);
        }),
    );
  }

  Widget buildrow(String name, int quantity, int index){
    return Row(
      children: [
        Text(name),
        Text("Quantity: $quantity"),
        ElevatedButton(
          onPressed: () async {
            cartList[index].quantity++;
            updateCart();
            }, 
          child: const Text("+")),
        ElevatedButton(
          onPressed: () async {
            cartList[index].quantity--;
            updateCart();
            }, 
          child: const Text("-")),  
      ],
    );
  }
  void getCart() async {
    if (user != null){
      cartItems = await dbService.getCartItems(user!.uid);
      if (cartItems.isNotEmpty){
        cartList = cartItems.entries.map((e) => CartItem(bookID: e.key, quantity: e.value)).toList();
      }
      print(cartItems);
      print(cartList);
    }
  }

  void updateCart() async {
    if(user != null){
      Map<String, int> temp = {};
      for (int i = 0; i < cartList.length; i++){
        temp[cartList[i].bookID] = cartList[i].quantity;
      }
      dynamic result = await dbService.updateUserCartItems(user!.uid, temp);
    }
  }
}
