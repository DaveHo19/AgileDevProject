import 'package:agile_project/models/cart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/class%20for%20testing/CartTest.dart';

void main() {
  test(
      'Test 1: Check the cart quantity for 1 cart object with add cart quantity function and the expected result is 2',
      () {
    final testCart = TestCart();
    int index = 0;
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 3,
        cartQuantity: 0);

    cartList.add(cartObject);

    testCart.increCart(cartList, index);
    testCart.increCart(cartList, index);

    expect(cartList[index].cartQuantity, 2);
  });

  test(
      'Test 2: Check the cart quantity for 1 cart object with decrease cart quantity function and the expected result is 2',
      () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 5,
        cartQuantity: 5);

    cartList.add(cartObject);

    //carry out increment for cart object in cartList[0]
    testCart.decreCart(cartList, 0);
    testCart.decreCart(cartList, 0);
    testCart.decreCart(cartList, 0);

    expect(cartList[0].cartQuantity, 2);
  });

  test(
      'Test 3: Check the cart quantity for 2 cart object with add cart quantity function and the expected result is 3 for cart object 1 and 10 for cart object 2',
      () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 3,
        cartQuantity: 1);

    cartList.add(cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "256-1-671-52955-9",
        title: "The Magicians 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 26.30,
        quantity: 12,
        cartQuantity: 6);

    cartList.add(cartObject2);

    //carry out increment for cart object in cartList[0]
    testCart.increCart(cartList, 0);
    testCart.increCart(cartList, 0);
    //carry out increment for cart object in cartList[1]
    testCart.increCart(cartList, 1);
    testCart.increCart(cartList, 1);
    testCart.increCart(cartList, 1);
    testCart.increCart(cartList, 1);

    expect(cartList[0].cartQuantity, 3);
    expect(cartList[1].cartQuantity, 10);
  });

  test(
      'Test 4: Check the cart quantity for 2 cart object with decrease cart quantity function and the expected result is 3 for cart object 1 and 7 for cart object 2',
      () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 6,
        cartQuantity: 6);

    cartList.add(cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "256-1-671-52955-9",
        title: "The Magicians 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 26.30,
        quantity: 12,
        cartQuantity: 11);

    cartList.add(cartObject2);

    //carry out increment for cart object in cartList[0]
    testCart.decreCart(cartList, 0);
    testCart.decreCart(cartList, 0);
    testCart.decreCart(cartList, 0);

    //carry out increment for cart object in cartList[1]
    testCart.decreCart(cartList, 1);
    testCart.decreCart(cartList, 1);
    testCart.decreCart(cartList, 1);
    testCart.decreCart(cartList, 1);

    expect(cartList[0].cartQuantity, 3);
    expect(cartList[1].cartQuantity, 7);
  });

  test(
      'Test 5: Check the cart quantity for 1 cart object with add and decrease cart quantity function and the expected result is 9',
      () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 15,
        cartQuantity: 7);

    cartList.add(cartObject);

    //carry out increment for cart object in cartList[0]
    testCart.increCart(cartList, 0);
    testCart.increCart(cartList, 0);
    testCart.increCart(cartList, 0);
    testCart.increCart(cartList, 0);
    testCart.decreCart(cartList, 0);
    testCart.decreCart(cartList, 0);
    testCart.decreCart(cartList, 0);
    testCart.increCart(cartList, 0);

    expect(cartList[0].cartQuantity, 9);
  });
}
