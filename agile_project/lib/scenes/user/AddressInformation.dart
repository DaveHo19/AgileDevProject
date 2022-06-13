import 'dart:html';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/scenes/user/AddNewAddressScene.dart';
import 'package:agile_project/scenes/user/Address1Scene.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/user/ProfileScene.dart';
import 'package:agile_project/scenes/user/AddressBody.dart';
import 'package:provider/provider.dart';

class MyAddressScene extends StatefulWidget {
  const MyAddressScene({Key? key}) : super(key: key);

  @override
  State<MyAddressScene> createState() => _MyAddressSceneState();
}

class _MyAddressSceneState extends State<MyAddressScene> {
  Map<String, String> addressMap = {};
  List<String> keysList = [];
  List<String> valuesList = [];
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
          keysList.add(key);
          valuesList.add(addressMap[key] ?? "");
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
              return buildListItem(keysList[i], valuesList[i]);
            }),
      ),
    );
  }

  Widget buildListItem(String name, String address) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        // padding: EdgeInsets.all(20),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        // color: Color(0xFFF5F6F9),
        //onPressed: press,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Address1Scene(
                        uid: user!.uid,
                        data: '',
                      )));
        },
        child: Row(children: [
          // SvgPicture.asset(
          //   icon,
          //   width: 22,
          //   color: kPrimaryColor,
          // ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Icon(Icons.arrow_forward_ios)
        ]),
      ),
    );
  }

  Widget buildContent() {
    return Column(
      children: [
        // //ProfilePic(),
        // SizedBox(height: 20),
        // ProfileMenu(
        //   icon: "icons/usericon.png",
        //   text: "Address 1",
        //   press: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => Address1Scene()));
        //   },
        // ),
        ProfileMenu(
          icon: "images/signup_top.png",
          text: "Add New Address",
        ),
        buildListView(),
      ],
    );
  }
}
// class MyAddressScene extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Addresses"),
//       ),
//       body:
//     );
//   }
//}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    //required this.press,
  }) : super(key: key);

  final String text, icon;
  //final void press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        // padding: EdgeInsets.all(20),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        // color: Color(0xFFF5F6F9),
        //onPressed: press,
        onPressed: () {},
        child: Row(children: [
          // SvgPicture.asset(
          //   icon,
          //   width: 22,
          //   color: kPrimaryColor,
          // ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Icon(Icons.arrow_forward_ios)
        ]),
      ),
    );
  }
}
