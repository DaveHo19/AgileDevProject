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
                  addDummyDataForWishList("Test");
                  },
                child: const Text("Test"),),
                ElevatedButton(
                  onPressed: () async {
                  print("test2");
                  addDummyDataForWishList("Test2");
                  },
                child: const Text("Test2"),)
          ])),
        ),
      );
  }

  void initialUserInfo() async {
    print("initialUserInfo run #1");
    var user = Provider.of<AppUser?>(context);
    // DatabaseService dbService = DatabaseService();
    // if (user != null){
    //   print("initialUserInfo run #2 - user not null");
    //   UserInfomation userInfo = await dbService.getUserInformation(user.uid);
    //   // Map<String, String> currentAddressMap = userInfo.addressMap;
    //   print("initialUserInfo run #2.5 - created userInfo");
    //   billingAddress = userInfo.addressMap;
    //   print("initialUserInfo run #3 - Get billing address");   
    //   if (billingAddress.isNotEmpty){
    //     print("initialUserInfo run #4 - billing address not null");
    //     billingAddress.forEach((key, value) {
    //       print(key.toString());
    //       print(value.toString());
          
    //     });
    //   } else {
    //     print ("Map is currently empty");
    //   }
    //   List<dynamic> tempList = userInfo.wishList;
    //   print("initialUserInfo run #5 - get wish list");
    //   if (tempList.isNotEmpty){
    //     print("initialUserInfo run #6 - Wislist not null");
    //     tempList.forEach((element) {
    //       wishList.add(element.toString());
    //     });
    //   } else {
    //     print ("Wishlist is currently empty");
    //   }
    // } else {
    //   print("There is no user login");
    // }   
    DatabaseService dbService = DatabaseService();
    if (user != null){
      userId = user.uid;
    List<dynamic> tList = await dbService.getUserWishlist(userId);
    if (tList.isNotEmpty){
      tList.forEach((element) {
        wishList.add(tList.toString());
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
}