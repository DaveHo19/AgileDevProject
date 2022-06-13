import 'dart:html';
import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:flutter/material.dart';

class NewAddressScene extends StatefulWidget {
  const NewAddressScene({Key? key, required this.uid}) : super(key: key);

  final String uid;
  @override
  State<NewAddressScene> createState() => _NewAddressSceneState();
}

class _NewAddressSceneState extends State<NewAddressScene> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add New Address"),
        ),
        body: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              decoration: inputDecoration("Address Name"),
              controller: nameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              decoration: inputDecoration("New Address"),
              controller: addressController,
              minLines: 5,
              maxLines: 10,
            ),
          ),
          RoundedButton(
            text: "Save",
            press: () async {
              createAddress();
            },
          ),
        ],
      ),
    );
  }

  void createAddress() async {
    DatabaseService dbService = DatabaseService();
    Map<String, String> map = await dbService.getBillingAddress(widget.uid);
    if (!map.containsKey(nameController.text)) {
      map[nameController.text] = addressController.text;
      dynamic result =
          await dbService.updateUserBillingAddress(widget.uid, map);
      if (result == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Sucess")));
          Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Failed")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("The address name is already exitst!")));
    }
  }
}

// class AddNewAddressScene extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Add New Address"),
//       ),
//       body: EditNewAddressBody(),
//     );
//   }
// }
