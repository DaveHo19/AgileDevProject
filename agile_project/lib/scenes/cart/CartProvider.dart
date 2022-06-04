import 'package:agile_project/models/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartProvider with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("cart_item", _counter);
    prefs.setDouble("total_price", _totalPrice);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt("cart_item") ?? 0;
    _totalPrice = prefs.getDouble("total_price") ?? 0.0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter(int i) {
    _counter = _counter - i;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }

  void addTotalPrice(double retailPrice) {
    _totalPrice = _totalPrice + retailPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeTotalPrice(double retailPrice) {
    _totalPrice = _totalPrice - retailPrice;
    _setPrefItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItems();
    return _totalPrice;
  }

  void clearPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String ISBN_13, String title, String imageCoverURL,
      double retailPrice, int quantity, int cartQuantity) {
    if (_items.containsKey(ISBN_13)) {
      _items.update(
          ISBN_13,
          (existingcartQuantity) => Cart(
              ISBN_13: existingcartQuantity.ISBN_13,
              title: existingcartQuantity.title,
              imageCoverURL: existingcartQuantity.imageCoverURL,
              retailPrice: existingcartQuantity.retailPrice,
              quantity: existingcartQuantity.quantity,
              cartQuantity: existingcartQuantity.cartQuantity + 1));
      addCounter();
      addTotalPrice(retailPrice);
    } else {
      _items.putIfAbsent(
          ISBN_13,
          () => Cart(
              ISBN_13: ISBN_13,
              title: title,
              imageCoverURL: imageCoverURL,
              retailPrice: retailPrice,
              quantity: quantity,
              cartQuantity: 1));
      addCounter();
      addTotalPrice(retailPrice);
    }
    notifyListeners();
  }

  void removeItem(String ISBN_13, int i, double totalItemPrice) {
    _items.remove(ISBN_13);
    removeCounter(i);
    removeTotalPrice(totalItemPrice);
    notifyListeners();
  }

  void removeSingleItem(String ISBN_13) {
    if (!_items.containsKey(ISBN_13)) {
      return;
    } else if (_items[ISBN_13]!.cartQuantity > 1) {
      _items.update(
          ISBN_13,
          (existingcartQuantity) => Cart(
              ISBN_13: existingcartQuantity.ISBN_13,
              title: existingcartQuantity.title,
              imageCoverURL: existingcartQuantity.imageCoverURL,
              retailPrice: existingcartQuantity.retailPrice,
              quantity: existingcartQuantity.quantity,
              cartQuantity: existingcartQuantity.cartQuantity - 1));
      removeCounter(1);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    _counter = 0;
    _totalPrice = 0.0;
    _setPrefItems();
    notifyListeners();
  }
}
