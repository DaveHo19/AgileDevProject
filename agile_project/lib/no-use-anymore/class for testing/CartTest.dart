import 'package:agile_project/no-use-anymore/cart.dart';

class TestCart {
  int totalCartQuantity = 0;

  void addToCart(List<Cart> cartList, Cart cartObject) {
    int cartQuantity = cartObject.cartQuantity + 1;

    Cart tempCartObject = Cart(
        ISBN_13: cartObject.ISBN_13,
        title: cartObject.title,
        imageCoverURL: cartObject.imageCoverURL,
        retailPrice: cartObject.retailPrice,
        quantity: cartObject.quantity,
        cartQuantity: cartQuantity);

    cartList.add(tempCartObject);
  }

  int countTotalCartQuantity(List<Cart> cartList) {
    for (int i = 0; i < cartList.length; i++) {
      totalCartQuantity = totalCartQuantity + cartList[i].cartQuantity;
    }
    return totalCartQuantity;
  }

  void increCart(List<Cart> cartList, int index) {
    if (cartList[index].cartQuantity < cartList[index].quantity) {
      cartList[index] = Cart(
          ISBN_13: cartList[index].ISBN_13,
          title: cartList[index].title,
          imageCoverURL: cartList[index].imageCoverURL,
          retailPrice: cartList[index].retailPrice,
          quantity: cartList[index].quantity,
          cartQuantity: cartList[index].cartQuantity + 1);
    } else {
      cartList[index] = Cart(
          ISBN_13: cartList[index].ISBN_13,
          title: cartList[index].title,
          imageCoverURL: cartList[index].imageCoverURL,
          retailPrice: cartList[index].retailPrice,
          quantity: cartList[index].quantity,
          cartQuantity: cartList[index].cartQuantity + 0);
    }
  }

  void decreCart(List<Cart> cartList, int index) {
    if (cartList[index].cartQuantity > 1) {
      cartList[index] = Cart(
          ISBN_13: cartList[index].ISBN_13,
          title: cartList[index].title,
          imageCoverURL: cartList[index].imageCoverURL,
          retailPrice: cartList[index].retailPrice,
          quantity: cartList[index].quantity,
          cartQuantity: cartList[index].cartQuantity - 1);
    } else {
      cartList[index] = Cart(
          ISBN_13: cartList[index].ISBN_13,
          title: cartList[index].title,
          imageCoverURL: cartList[index].imageCoverURL,
          retailPrice: cartList[index].retailPrice,
          quantity: cartList[index].quantity,
          cartQuantity: cartList[index].cartQuantity - 0);
    }
  }

  bool checkIncreCartQuantity(List<Cart> cartList, int index) {
    if (cartList[index].cartQuantity + 1 > cartList[index].quantity) {
      return false;
    } else {
      return true;
    }
  }

  bool checkDecreCartQuantity(List<Cart> cartList, int index) {
    if (cartList[index].cartQuantity - 1 < 1) {
      return false;
    } else {
      return true;
    }
  }

  void removeCartObject(List<Cart> cartList, int index) {
    cartList.removeAt(index);
  }
}
