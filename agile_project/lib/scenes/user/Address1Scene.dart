import 'dart:html';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/user/ProfileScene.dart';
import 'package:agile_project/scenes/user/ProfileBody.dart';
import 'package:agile_project/scenes/user/AddressBody.dart';
import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';

class Address1Scene extends StatefulWidget {
  const Address1Scene({
    Key? key,
    required this.data,
    required this.uid,
  }) : super(key: key);

  final String uid;
  final String data;

  @override
  State<Address1Scene> createState() => _Address1SceneState();
}

class _Address1SceneState extends State<Address1Scene> {
  final TextEditingController fieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fieldController.text = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Contact Number"),
      ),
      body: buildContent(),
    );
  }

  Widget buildContent() {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: fieldController,
              validator: (String? val) => (val != null && val.isNotEmpty)
                  ? "Enter the New Address"
                  : null,
              decoration: inputDecoration("New Address"),
            ),
          ),
          RoundedButton(
            text: "Save",
            press: () async {
              updateNewAddress();
            },
          ),
        ],
      ),
    );
  }

  void updateNewAddress() async {
    DatabaseService dbService = DatabaseService();
    dynamic result = await dbService.updateUserBillingAddress(
        widget.uid, fieldController.text);
    if (result == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Sucess")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed")));
    }
  }
}

// class Address1Scene extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Address 1"),
//       ),
//       //body: EditNameBody(),
//     );
//   }
// }
