import 'package:agile_project/models/cart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/class%20for%20testing/CartTest.dart';

//check the cart quantity can be increment, decrement or cannot be increment, decrement with the quantity of a book in stock,
//when return false mean cannot increment or decrement, if return true mean can increment or decrement
void main() {
  test(
      'Test 1: Check cart quantity of 1 cart object can be increment or not and expected result is true',
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
        cartQuantity: 2);

    cartList.add(cartObject);

    expect(testCart.checkIncreCartQuantity(cartList, index), true);
  });

  test(
      'Test 2: Check cart quantity of 1 cart object can be decrement or not and expected result is true',
      () {
    final testCart = TestCart();
    int index = 0;
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 12,
        cartQuantity: 2);

    cartList.add(cartObject);

    expect(testCart.checkIncreCartQuantity(cartList, index), true);
  });

  test(
      'Test 3: Check cart quantity of 2 cart object can be increment or not and expected result is cart object 1 is true and cart object 2 is false',
      () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians 2",
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
        cartQuantity: 9);

    cartList.add(cartObject2);

    expect(testCart.checkIncreCartQuantity(cartList, 0), true);
    expect(testCart.checkIncreCartQuantity(cartList, 1), false);
  });

  test(
      'Test 4: Check cart quantity of 2 cart object can be decrement or not and expected result is cart object 1 is false and cart object 2 is true',
      () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 3,
        cartQuantity: 1);

    cartList.add(cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "0-374-28698-5",
        title: "The Virgin Suicides 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F0-374-28438-5?alt=media&token=6f61b17f-ee49-46a7-9010-c93f0f070746",
        retailPrice: 27.20,
        quantity: 9,
        cartQuantity: 2);

    cartList.add(cartObject2);

    expect(testCart.checkDecreCartQuantity(cartList, 0), false);
    expect(testCart.checkDecreCartQuantity(cartList, 1), true);
  });

  test(
      'Test 5: Check cart quantity of 2 cart object can be increment, decrement or cannot and expected result is cart object 1 is false and cart object 2 is true',
      () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 3,
        cartQuantity: 3);

    cartList.add(cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "0-374-28698-5",
        title: "The Virgin Suicides 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F0-374-28438-5?alt=media&token=6f61b17f-ee49-46a7-9010-c93f0f070746",
        retailPrice: 27.20,
        quantity: 9,
        cartQuantity: 2);

    cartList.add(cartObject2);

    expect(testCart.checkIncreCartQuantity(cartList, 0), false);
    expect(testCart.checkDecreCartQuantity(cartList, 1), true);
  });
}
