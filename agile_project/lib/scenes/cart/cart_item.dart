import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../cart/CartProvider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:agile_project/models/cart.dart';

class CartItem extends StatefulWidget {
  CartItem(
      {Key? key,
      required this.ISBN_13,
      required this.title,
      required this.imageCoverURL,
      required this.retailPrice,
      required this.quantity,
      required this.cartQuantity})
      : super(key: key);

  String ISBN_13;
  final String title;
  String imageCoverURL;
  final double retailPrice;
  final int quantity;
  final int cartQuantity;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
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
    return ListTile(
      leading: Image.network(widget.imageCoverURL, fit: BoxFit.fill),
      title: Text("Book Name: ${widget.title}"),
      subtitle: Text(
          "Total Price: RM ${double.parse((widget.retailPrice * widget.cartQuantity).toStringAsFixed(2))}"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget.cartQuantity != 1
              ? IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    cart.removeItem(widget.ISBN_13, 1);

                    if (cartBox.containsKey(widget.ISBN_13)) {
                      int cartQuantity =
                          cartBox.get(widget.ISBN_13)!.cartQuantity - 1;

                      Cart tempObject = Cart(
                          ISBN_13: widget.ISBN_13,
                          title: widget.title,
                          imageCoverURL: widget.imageCoverURL,
                          retailPrice: widget.retailPrice,
                          quantity: widget.quantity,
                          cartQuantity: cartQuantity);

                      cartBox.put(widget.ISBN_13, tempObject);
                    }
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Reach minimum value!"),
                      duration: const Duration(seconds: 2),
                    ))
                  },
                ),
          Text(widget.cartQuantity.toString()),
          widget.cartQuantity == widget.quantity
              ? IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Reach maximum value!"),
                      duration: const Duration(seconds: 2),
                    ))
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    cart.addItem(
                        widget.ISBN_13,
                        widget.title,
                        widget.imageCoverURL,
                        widget.retailPrice,
                        widget.quantity,
                        1);

                    Cart cartObject = Cart(
                        ISBN_13: widget.ISBN_13,
                        title: widget.title,
                        imageCoverURL: widget.imageCoverURL,
                        retailPrice: widget.retailPrice,
                        quantity: widget.quantity,
                        cartQuantity: 1);

                    if (cartBox.containsKey(cartObject.ISBN_13)) {
                      int cartQuantity =
                          cartBox.get(cartObject.ISBN_13)!.cartQuantity + 1;

                      Cart tempObject = Cart(
                          ISBN_13: widget.ISBN_13,
                          title: widget.title,
                          imageCoverURL: widget.imageCoverURL,
                          retailPrice: widget.retailPrice,
                          quantity: widget.quantity,
                          cartQuantity: cartQuantity);

                      cartBox.put(cartObject.ISBN_13, tempObject);
                    }
                  }),
          IconButton(
            alignment: Alignment.topRight,
            icon: const Icon(Icons.delete),
            onPressed: () => {
              // cartBox.delete(widget.ISBN_13),
              // cart.removeItem(widget.ISBN_13, widget.cartQuantity),
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Removed the Book : ${widget.title}"),
                duration: const Duration(seconds: 1),
              ))
            },
          ),
        ],
      ),
    );
  }
}
