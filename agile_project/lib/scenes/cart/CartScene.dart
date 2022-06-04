import 'package:agile_project/scenes/cart/CartProvider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../cart/CartProvider.dart';
import '../cart/cart_item.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:agile_project/models/cart.dart';

class MyCartScene extends StatefulWidget {
  const MyCartScene({Key? key}) : super(key: key);

  @override
  State<MyCartScene> createState() => _MyCartSceneState();
}

class _MyCartSceneState extends State<MyCartScene> {
  late Box<Cart> cartBox;

  @override
  void initState() {
    super.initState();
    cartBox = Hive.box("cart_items");
    // cartBox.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    print(double.parse(cart.getTotalPrice().toStringAsFixed(2)));
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
            child: ValueListenableBuilder(
                valueListenable: cartBox.listenable(),
                builder: (context, Box<Cart> box, _) {
                  List<Cart> carts = box.values.toList().cast<Cart>();

                  return ListView.builder(
                      itemCount: carts.length,
                      itemBuilder: (context, index) => CartItem(
                            ISBN_13: carts.toList()[index].ISBN_13,
                            title: carts.toList()[index].title,
                            imageCoverURL: carts.toList()[index].imageCoverURL,
                            retailPrice: carts.toList()[index].retailPrice,
                            quantity: carts.toList()[index].quantity,
                            cartQuantity: carts.toList()[index].cartQuantity,
                          ));
                }),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          Material(
            color: Color.fromARGB(255, 238, 69, 69),
            child: InkWell(
              onTap: () {
                cartBox.clear();
                cart.clear();
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
