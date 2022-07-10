import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/no-use-anymore/cart.dart';
import 'package:agile_project/no-use-anymore/class%20for%20testing/CartTest.dart';

void main() {
  test('Test 1: There are 1 cart data have been stored', () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 3,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject);

    expect(cartList.length, 1);
  });

  test('Test 2: There are 2 cart data have been stored', () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "941-1-514-52795-9",
        title: "The Magicians 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 23.30,
        quantity: 13,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 3,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject2);

    expect(cartList.length, 2);
  });

  test('Test 3: There are 3 cart data have been stored', () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "941-1-514-52795-9",
        title: "The Magicians 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 23.30,
        quantity: 13,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 3,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject2);

    Cart cartObject3 = Cart(
        ISBN_13: "0-374-28438-5",
        title: "The Virgin Suicides",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F0-374-28438-5?alt=media&token=6f61b17f-ee49-46a7-9010-c93f0f070746",
        retailPrice: 31.20,
        quantity: 15,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject3);

    expect(cartList.length, 3);
  });

  test('Test 4: There are 4 cart data have been stored', () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "941-1-514-52795-9",
        title: "The Magicians 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 23.30,
        quantity: 13,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 3,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject2);

    Cart cartObject3 = Cart(
        ISBN_13: "0-374-28438-5",
        title: "The Virgin Suicides",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F0-374-28438-5?alt=media&token=6f61b17f-ee49-46a7-9010-c93f0f070746",
        retailPrice: 31.20,
        quantity: 15,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject3);

    Cart cartObject4 = Cart(
        ISBN_13: "0-374-28698-5",
        title: "The Virgin Suicides 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F0-374-28438-5?alt=media&token=6f61b17f-ee49-46a7-9010-c93f0f070746",
        retailPrice: 27.20,
        quantity: 9,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject4);

    expect(cartList.length, 4);
  });

  test('Test 5: There are 1 cart data have been stored', () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-8-968-28935-3",
        title: "The Magicians 3",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 49.30,
        quantity: 3,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject);

    expect(cartList.length, 1);
  });
}
