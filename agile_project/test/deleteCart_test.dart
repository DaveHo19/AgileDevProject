import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/no-use-anymore/cart.dart';
import 'package:agile_project/no-use-anymore/class%20for%20testing/CartTest.dart';

void main() {
  test(
      'Test 1: Check cart object is remove or not and the expected result is 0',
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
        cartQuantity: 2);

    cartList.add(cartObject);

    testCart.removeCartObject(cartList, 0);

    expect(cartList.length, 1);
  });

  test(
      'Test 2: Check to see first cart object is remove from the list or not and left second cart object in list and the expected result is 1',
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
        cartQuantity: 2);

    cartList.add(cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "0-374-28698-5",
        title: "The Virgin Suicides 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F0-374-28438-5?alt=media&token=6f61b17f-ee49-46a7-9010-c93f0f070746",
        retailPrice: 27.20,
        quantity: 9,
        cartQuantity: 3);

    testCart.addToCart(cartList, cartObject2);

    testCart.removeCartObject(cartList, 0);

    expect(cartList.length, 1);
    expect(cartList[0].title, "The Virgin Suicides 2");
  });

  test(
      'Test 4: Check to see first cart object and second cart object is remove from the list and the expected result is 0',
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
        cartQuantity: 2);

    cartList.add(cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "0-374-28698-5",
        title: "The Virgin Suicides 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F0-374-28438-5?alt=media&token=6f61b17f-ee49-46a7-9010-c93f0f070746",
        retailPrice: 27.20,
        quantity: 9,
        cartQuantity: 3);

    testCart.addToCart(cartList, cartObject2);

    testCart.removeCartObject(cartList, 0);

    expect(cartList.length, 1);
  });

  test(
      'Test 3: Check to see second cart object is remove from the list and left first cart object, third object in list and the expected result is 2',
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
        cartQuantity: 2);

    cartList.add(cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "0-374-28698-5",
        title: "The Virgin Suicides 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F0-374-28438-5?alt=media&token=6f61b17f-ee49-46a7-9010-c93f0f070746",
        retailPrice: 27.20,
        quantity: 9,
        cartQuantity: 3);

    testCart.addToCart(cartList, cartObject2);

    Cart cartObject3 = Cart(
        ISBN_13: "941-1-514-52795-9",
        title: "The Magicians 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 23.30,
        quantity: 13,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject3);

    testCart.removeCartObject(cartList, 1);

    expect(cartList.length, 2);
    expect(cartList[0].title, "The Magicians");
    expect(cartList[1].title, "The Magicians 2");
  });

  test(
      'Test 5: Check to see all cart object is remove from the list and the expected result is 0',
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
        cartQuantity: 2);

    cartList.add(cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "0-374-28698-5",
        title: "The Virgin Suicides 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F0-374-28438-5?alt=media&token=6f61b17f-ee49-46a7-9010-c93f0f070746",
        retailPrice: 27.20,
        quantity: 9,
        cartQuantity: 3);

    testCart.addToCart(cartList, cartObject2);

    Cart cartObject3 = Cart(
        ISBN_13: "941-1-514-52795-9",
        title: "The Magicians 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 23.30,
        quantity: 13,
        cartQuantity: 0);

    testCart.addToCart(cartList, cartObject3);

    testCart.removeCartObject(cartList, 0);
    testCart.removeCartObject(cartList, 0);
    testCart.removeCartObject(cartList, 0);

    expect(cartList.length, 0);
  });
}
