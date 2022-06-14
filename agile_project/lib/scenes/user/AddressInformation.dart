import 'package:agile_project/models/address.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/scenes/user/AddNewAddressScene.dart';
import 'package:agile_project/scenes/user/ViewAddressScene.dart';
import 'package:agile_project/scenes/user/ProfileMenu.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAddressScene extends StatefulWidget {
  const MyAddressScene({Key? key}) : super(key: key);

  @override
  State<MyAddressScene> createState() => _MyAddressSceneState();
}

class _MyAddressSceneState extends State<MyAddressScene> {
  Map<String, String> addressMap = {};  
  List<BillingAddress> addressList = [];

  AppUser? user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    return FutureBuilder(
        future: initialAddress(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Loading();
          } else {
            return buildListView();
          }
        });
  }

  Future initialAddress() async {
    DatabaseService dbService = DatabaseService();
    if (user != null) {
      addressMap = await dbService.getBillingAddress(user!.uid);
      if (addressMap.isNotEmpty) {
        for (var key in addressMap.keys) {
          addressList.add(BillingAddress(name: key, address: addressMap[key] ?? ""));
        }
      }
    }
  }

  Widget buildListView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewAddressScene(
                            uid: user!.uid,
                          )));
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: initialAddress,
        child: ListView.builder(
            itemCount: addressMap.length,
            itemBuilder: (context, i) {
              return buildListItem(addressList[i]);
            }),
      ),
    );
  }

  Widget buildListItem(BillingAddress address) {
    return ProfileMenu(
      text: address.name, 
      press: (){
        if (user != null){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAddressScene(data: address, uid: user!.uid)));
        }
      }, 
      icons: const Icon(Icons.home), 
      value: "");
    
  }
}

