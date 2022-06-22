import 'package:agile_project/models/address.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/scenes/user/AddNewAddressScene.dart';
import 'package:agile_project/scenes/user/ViewAddressScene.dart';
import 'package:agile_project/scenes/user/ProfileMenu.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilities/custom_dialog.dart';

class MyAddressScene extends StatefulWidget {
  const MyAddressScene({
    Key? key,
    required this.addressType,
    }) : super(key: key);

  final AddressType addressType;
  @override
  State<MyAddressScene> createState() => _MyAddressSceneState();
}

class _MyAddressSceneState extends State<MyAddressScene> {
  Map<String, String> addressMap = {};  
  List<LocationAddress> addressList = [];

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
      switch(widget.addressType){
        case AddressType.billing: 
          addressMap = await dbService.getBillingAddress(user!.uid);
        break;
        case AddressType.shipping:
          addressMap = await dbService.getShippingAddress(user!.uid);
        break;
      }
      if (addressMap.isNotEmpty) {
        for (var key in addressMap.keys) {
          addressList.add(LocationAddress(name: key, address: addressMap[key] ?? ""));
        }
      }
    }
  }

  Widget buildListView() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.addressType == AddressType.billing ? "Billing Address" : "Shipping Address"
          ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewAddressScene(
                            uid: user!.uid,
                            addressType: widget.addressType,
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

  Widget buildListItem(LocationAddress address) {
    return ProfileMenu(
      text: address.name, 
      press: (){
        if (user != null){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewAddressScene(data: address, uid: user!.uid, addressType: widget.addressType)));
        }
      }, 
      longPress: () async {
        deleteProcess(address);
      },
      icons: const Icon(Icons.home), 
      value: "");
  }

  void deleteProcess(LocationAddress address) async {
    CustomDialog customDialog = CustomDialog();
    DatabaseService dbService = DatabaseService();
    if (user != null){
      bool result = await customDialog.confirm_dialog(context, "Confirmation Dialog", "Are you sure to remove this address from your current address?");
      if (result){
        if (addressMap.containsKey(address.name)){
          addressMap.remove(address.name);
          dynamic res;
          switch (widget.addressType){
            case AddressType.billing:
              res = await dbService.updateUserBillingAddress(user!.uid, addressMap);
            break;
            case AddressType.shipping:
              res = await dbService.updateUserShippingAddress(user!.uid, addressMap);
            break;
          } 

          if (res == null){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Removed!")));
            setState(() {});
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to Remove!")));
          }
        }
      }
    }
  }
}

