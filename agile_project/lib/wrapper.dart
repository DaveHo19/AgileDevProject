import 'package:agile_project/constants.dart';
import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/cartItem.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/admin-only/StockLevelScene.dart';
import 'package:agile_project/scenes/debug/debug_auth.dart';
import 'package:agile_project/scenes/debug/debug_cart.dart';
import 'package:agile_project/scenes/debug/debug_image.dart';
import 'package:agile_project/scenes/home/HomeScene.dart';
import 'package:agile_project/scenes/product/CartScene.dart';
import 'package:agile_project/scenes/product/ManageProductScene.dart';
import 'package:agile_project/scenes/product/OrderProductScene.dart';
import 'package:agile_project/scenes/product/ViewProductScene.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/scenes/user/ProfileBody.dart';
import 'package:agile_project/scenes/wish-list/WishlistScene.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:agile_project/services/manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/enumList.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  //initial scene for bottom navigator
  int _selectedNavIndex = 0;
  String currentContentTitle = "Home";
  AppUser? user;

  void _onItemTapped(int index) {
    setState(() {
      _selectedNavIndex = index;
      switch (_selectedNavIndex) {
        case 0:
          currentContentTitle = "Home";
          break;
        case 1:
          currentContentTitle = "My Wishlist";
          break;
        case 2:
          currentContentTitle = "My Profile";
          break;
      }
    });
  }

  //for navigation scene
  static final List<Widget> _bottomNavigationScene = <Widget>[];

  @override
  void initState() {
    super.initState();
    //for linking navigation scene
    _initialBottomNavigationScene();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    return (user != null && !Manager.initialized)
        ? FutureBuilder(
            future: initializeDataInformation(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Loading();
              } else {
                return buildContent();
              }
            })
        : buildContent();
  }

  Widget buildContent() {
    return Scaffold(
      //top bar
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        foregroundColor: kPrimaryLightColor,
        title: Text(currentContentTitle),
        actions: [
          (user != null)
              ? ElevatedButton.icon(
                  onPressed: () async {
                    bool result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyCartScene()));
                    if (result) {
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.shopping_cart),
                  label: Text(Manager.estimatedPrice.toStringAsFixed(2)),
                  style: ElevatedButton.styleFrom(primary: Colors.transparent))
              : Container(),
          //debug purpose
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("StockLevel"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Checkout"),
              ),
            ],
            onSelected: (int i) => {debugHandler(context, i)},
          ),
        ],
      ),
      body:
          SafeArea(child: _bottomNavigationScene.elementAt(_selectedNavIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedNavIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: (Manager.currAccountType == AccountType.admin)
          ? FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: _onFabTapped,
              child: const Icon(
                Icons.settings,
                color: kPrimaryLightColor,
              ))
          : null,
    );
  }

  //for passing function purpose
  void pass() {}

  void _initialBottomNavigationScene() {
    _bottomNavigationScene.clear();
    _bottomNavigationScene.add(const MyHomeScene());
    _bottomNavigationScene.add(const MyWishlistScene());
    //_bottomNavigationScene.add(const MyProfileScene());
    _bottomNavigationScene.add(ProfileScene());
  }

  void _onFabTapped() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const MyStockLevelScene()));
  }

  void debugHandler(BuildContext context, int i) {
    switch (i) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyStockLevelScene()));
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MyOrderProductScene()));
        break;
    }
  }

  Future initializeDataInformation() async {
    if (user != null) {
      DatabaseService dbService = DatabaseService();
      int level = await dbService.getAccountLevel(user!.uid);
      Manager.currAccountType = (level == 1)
          ? AccountType.user
          : (level == 0)
              ? AccountType.admin
              : AccountType.guest;
      await getEstimatePrice();
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
        Manager.initialized = true;
      }
    }
  }
}
