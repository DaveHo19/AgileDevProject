import 'package:agile_project/constants.dart';
import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/cartItem.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:agile_project/services/manager.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class MyCartScene extends StatefulWidget {
  const MyCartScene({Key? key}) : super(key: key);

  @override
  State<MyCartScene> createState() => _CartSceneState();
}

class _CartSceneState extends State<MyCartScene> {
  AppUser? user;
  List<Book> bookList = [];
  Map<String, int> cartItemMap = {};
  List<CartItem> cartItemList = [];
  bool isProcess = false;
  bool priceChanges = false;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, priceChanges);
        return Future.value(priceChanges);
      },
      child: isProcess
          ? const Loading()
          : FutureBuilder(
              future: initializeDataInformation(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Loading();
                } else {
                  return buildContent();
                }
              }),
    );
  }

  Widget buildContent() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Carts"),
        backgroundColor: kPrimaryColor,
        foregroundColor: kPrimaryLightColor,
      ),
      body: (cartItemMap.isEmpty)
          ? const Center(
              child: Text("There are no item in cart!"),
            )
          : buildListView(),
      bottomSheet: buildBottomLayer(),
    );
  }

  Widget buildListView() {
    return ListView.builder(
        itemCount: bookList.length,
        itemBuilder: (context, i) {
          return buildListViewItem(bookList[i]);
        });
  }

  Widget buildListViewItem(Book item) {
    double estimatedBookPrice = 0;
    int cartQuantity = cartItemMap[item.ISBN_13] ?? 0;
    estimatedBookPrice = item.retailPrice * cartQuantity;

    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      padding: const EdgeInsets.all(2),
      width: MediaQuery.of(context).size.width,
      height: 125,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 115,
          child: ListTile(
            leading: Container(
              width: 50,
              height: 300,
              child: Image.network(item.imageCoverURL, fit: BoxFit.fill),
            ),
            title: Text(item.title),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Quantity: ${cartQuantity.toString()} \n\nTotal Price: RM ${estimatedBookPrice.toStringAsFixed(2)}",
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          fixedSize: const Size(10, 10)),
                      child: const Text(
                        "-",
                        style: TextStyle(color: kPrimaryLightColor),
                      ),
                      onPressed: () async {
                        decreaseQuantity(item);
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: kPrimaryColor,
                          fixedSize: const Size(10, 10)),
                      child: const Text(
                        "+",
                        style: TextStyle(color: kPrimaryLightColor),
                      ),
                      onPressed: () async {
                        increaseQuantity(item);
                      },
                    ),
                  ],
                )
              ],
            ),
            onLongPress: () async {
              //remove actions
            },
          ),
        ),
      ),
    );
  }

  Widget buildBottomLayer() {
    return Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        child: 
        // Column(
        //   children: [
        //     Align(
        //       alignment: Alignment.centerLeft,
        //       child: Padding(
        //         padding: const EdgeInsets.all(2.0),
        //         child: Text(
        //           "Current Estimated Price: ${Manager.estimatedPrice.toStringAsFixed(2)}",
        //           style: const TextStyle(
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold,
        //               color: Colors.black),
        //         ),
        //       ),
        //     ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 80,
                    child: ElevatedButton(
                      child: const Text(
                        "Clear",
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 80,
                    child: ElevatedButton(
                      child: const Text(
                        "Proceed",
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          //],
        //)
        );
  }

  Future initializeDataInformation() async {
    if (user != null) {
      DatabaseService dbService = DatabaseService();
      cartItemMap = await dbService.getCartItems(user!.uid);
      if (cartItemMap.isNotEmpty) {
        List<String> bookISBNList =
            cartItemMap.entries.map((e) => e.key).toList();
        cartItemList = cartItemMap.entries
            .map((e) => CartItem(bookID: e.key, quantity: e.value))
            .toList();
        bookList = await dbService.getBookListByWishlist(bookISBNList);
      }
    }
  }

  void increaseQuantity(Book item) {
    int currQuantity = cartItemMap[item.ISBN_13]!;
    if (currQuantity >= item.quantity) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "The cart quantity had reach the maximum quantity in the stock!")));
    } else {
      cartItemMap[item.ISBN_13] = ++currQuantity;
      updateCart();
    }
  }

  void decreaseQuantity(Book item) {
    int currQuantity = cartItemMap[item.ISBN_13]!;
    if (currQuantity <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "The cart quantity had reach the minimum quantity of the product!")));
    } else {
      cartItemMap[item.ISBN_13] = --currQuantity;
      updateCart();
    }
  }

  void updateCart() async {
    if (user != null) {
      DatabaseService dbService = DatabaseService();
      setState(() {
        isProcess = true;
      });
      dynamic result =
          await dbService.updateUserCartItems(user!.uid, cartItemMap);
      setState(() {
        isProcess = false;
      });
      if (result == null) {
        await getEstimatePrice();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to perform actions!")));
      }
    }
  }

  Future getEstimatePrice() async {
    DatabaseService dbService = DatabaseService();
    Manager.estimatedPrice = 0;
    Map<String, int> cartItemMap = await dbService.getCartItems(user!.uid);
    if (cartItemMap.isNotEmpty && user != null) {
      List<CartItem> cartItemList = [];
      cartItemList = cartItemMap.entries
          .map((e) => CartItem(bookID: e.key, quantity: e.value))
          .toList();
      for (int i = 0; i < cartItemList.length; i++) {
        Book tempBook = await dbService.getBookByISBN(cartItemList[i].bookID);
        double priceForBook = tempBook.retailPrice * cartItemList[i].quantity;
        Manager.estimatedPrice += priceForBook;
      }
      setState(() {});
      priceChanges = true;
    }
  }
}
