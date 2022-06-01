import 'package:agile_project/scenes/cart/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart/CartProvider.dart';
import '../cart/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCartScene extends StatefulWidget {
  const MyCartScene({Key? key}) : super(key: key);

  @override
  State<MyCartScene> createState() => _MyCartSceneState();
}

class _MyCartSceneState extends State<MyCartScene> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    // cart.clearPref();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Column(
          children: [
            Text("Your Shopping Cart"),
            Text('Total ${cart.getCounter().toString()} items',
                style: TextStyle(fontSize: 14.0))
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) => CartItem(
                      ISBN_13: cart.items.values.toList()[index].ISBN_13,
                      title: cart.items.values.toList()[index].title,
                      imageCoverURL:
                          cart.items.values.toList()[index].imageCoverURL,
                      retailPrice:
                          cart.items.values.toList()[index].retailPrice,
                      quantity: cart.items.values.toList()[index].quantity,
                      cartQuantity:
                          cart.items.values.toList()[index].cartQuantity,
                    )),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          Material(
            color: Color.fromARGB(255, 238, 69, 69),
            child: InkWell(
              onTap: () {
                //print('called on tap');
              },
              child: const SizedBox(
                height: kToolbarHeight,
                width: 250,
                child: Center(
                  child: Text(
                    'Clear Cart',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Color.fromARGB(255, 27, 189, 238),
              child: InkWell(
                onTap: () {
                  //print('called on tap');
                },
                child: const SizedBox(
                  height: kToolbarHeight,
                  width: 250,
                  child: Center(
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
