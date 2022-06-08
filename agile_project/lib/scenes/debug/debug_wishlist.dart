import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/services/databaseService.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class DebugWishlist extends StatefulWidget {
  const DebugWishlist({ Key? key }) : super(key: key);

  @override
  State<DebugWishlist> createState() => _DebugWishlistState();
}

class _DebugWishlistState extends State<DebugWishlist> {
  List<String> wishList = <String>[];
  List<Book> wishListForBook = <Book>[];
  Map<String, dynamic> billingAddress = <String, dynamic>{};
  String userId = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initialUserInfo();
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Debug User & Wishlist'),
          elevation: 0.0,
        ),
        body: Container(
          child: Center(
            child: Column( 
              children: [ 
                ElevatedButton(
                  onPressed: () async {
                  print("test");
                  //addDummyDataForWishList("Test");
                  },
                child: const Text("Test"),),
                ElevatedButton(
                  onPressed: () async {
                  print("Debug");
                  printDebug();
                  },
                child: const Text("Test2"),),
                ElevatedButton(
                  onPressed: () async {
                    print("retrieve");
                    await displayBookList();
                  }, 
                  child: const Text("Retrieve book"))
          ])),
        ),
      );
  }

  void initialUserInfo() async {
    print("initialUserInfo run #1");
    var user = Provider.of<AppUser?>(context);
    DatabaseService dbService = DatabaseService();
    if (user != null){
      userId = user.uid;
    List<String> tList = await dbService.getUserWishlist(userId);
    if (tList.isNotEmpty){
      tList.forEach((element) {
        wishList.add(element);
      });
    } else{
      print ("List is empty");
    }
    }else{
      print ("User is null");
    }
  }

  void addDummyDataForWishList(String val) async {
    print("Checked #1");
    if(wishList.contains(val)){
      wishList.remove(val);
    } else {
      wishList.add(val);
    }
    DatabaseService dbService = DatabaseService();
    dynamic result = await dbService.updateUserWishlist(userId, wishList);
    if (result == null){ 
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Created!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed!")));
    }
  }
  
  Future displayBookList() async {
    print("D-Booklist Checked #1");
    DatabaseService dbService = DatabaseService();
    wishListForBook = await dbService.getBookListByWishlist(wishList);
    for (int i=0; i < wishListForBook.length; i++){
      wishListForBook.elementAt(i).toInfo();
    }
  }

  void printDebug(){
    print(wishListForBook.length);
  }
}