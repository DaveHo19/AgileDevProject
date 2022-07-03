import 'package:agile_project/models/cart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/class%20for%20testing/CartTest.dart';

void main() {
  test(
      'Test 1: Test count total cart quantity total function for 1 cart object and expected result is 2',
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

    testCart.countTotalCartQuantity(cartList);

    expect(testCart.totalCartQuantity, 2);
  });

  test(
      'Test 2: Test count total cart quantity total function for 2 cart object and expected result is 8',
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
        ISBN_13: "256-1-671-52955-9",
        title: "The Magicians 2",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 26.30,
        quantity: 12,
        cartQuantity: 6);

    cartList.add(cartObject2);

    testCart.countTotalCartQuantity(cartList);

    expect(testCart.totalCartQuantity, 8);
  });

  test(
      'Test 3: Test count total cart quantity total function for 3 cart object and expected result is 15',
      () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 12,
        cartQuantity: 7);

    cartList.add(cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "0-7475-4215-7",
        title: "Harry Potter and the Prisoner of Azkaban",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 34.35,
        quantity: 5,
        cartQuantity: 4);

    cartList.add(cartObject2);

    Cart cartObject3 = Cart(
        ISBN_13: "0-374-28438-5",
        title: "The Virgin Suicides",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 35.60,
        quantity: 6,
        cartQuantity: 4);

    cartList.add(cartObject3);

    testCart.countTotalCartQuantity(cartList);

    expect(testCart.totalCartQuantity, 15);
  });

  test(
      'Test 4: Test count total cart quantity total function for 4 cart object and expected result is 17',
      () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 12,
        cartQuantity: 4);

    cartList.add(cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "0-7475-4215-7",
        title: "Harry Potter and the Prisoner of Azkaban",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 34.35,
        quantity: 5,
        cartQuantity: 8);

    cartList.add(cartObject2);

    Cart cartObject3 = Cart(
        ISBN_13: "0-374-28438-5",
        title: "The Virgin Suicides",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 35.60,
        quantity: 6,
        cartQuantity: 3);

    cartList.add(cartObject3);

    Cart cartObject4 = Cart(
        ISBN_13: "0-7868-5629-7",
        title: "The Lightning Thief ",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 45.73,
        quantity: 3,
        cartQuantity: 2);

    cartList.add(cartObject4);

    testCart.countTotalCartQuantity(cartList);

    expect(testCart.totalCartQuantity, 17);
  });

  test(
      'Test 5: Test count total cart quantity total function for 5 cart object and expected result is 22',
      () {
    final testCart = TestCart();
    List<Cart> cartList = [];

    Cart cartObject = Cart(
        ISBN_13: "978-0-670-02055-3",
        title: "The Magicians",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 21.30,
        quantity: 12,
        cartQuantity: 4);

    cartList.add(cartObject);

    Cart cartObject2 = Cart(
        ISBN_13: "0-7475-4215-7",
        title: "Harry Potter and the Prisoner of Azkaban",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 34.35,
        quantity: 5,
        cartQuantity: 8);

    cartList.add(cartObject2);

    Cart cartObject3 = Cart(
        ISBN_13: "0-374-28438-5",
        title: "The Virgin Suicides",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 35.60,
        quantity: 6,
        cartQuantity: 3);

    cartList.add(cartObject3);

    Cart cartObject4 = Cart(
        ISBN_13: "0-7868-5629-7",
        title: "The Lightning Thief",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 45.73,
        quantity: 3,
        cartQuantity: 2);

    cartList.add(cartObject4);

    Cart cartObject5 = Cart(
        ISBN_13: "0679879242",
        title: "The Golden Compass",
        imageCoverURL:
            "https://firebasestorage.googleapis.com/v0/b/agileproject-abd4b.appspot.com/o/bookCoverImage%2F%09978-0-670-02055-3?alt=media&token=9a4f4d21-a17a-4689-86f1-a80f6ef35679",
        retailPrice: 23.73,
        quantity: 6,
        cartQuantity: 5);

    cartList.add(cartObject5);

    testCart.countTotalCartQuantity(cartList);

    expect(testCart.totalCartQuantity, 22);
  });
}
