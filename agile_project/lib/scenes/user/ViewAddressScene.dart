import 'dart:html';
import 'package:agile_project/models/address.dart';
import 'package:agile_project/scenes/user/EditAddressScene.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';

class ViewAddressScene extends StatefulWidget {
  const ViewAddressScene({
    Key? key,
    required this.data,
    required this.uid,
  }) : super(key: key);

  final String uid;
  final BillingAddress data;

  @override
  State<ViewAddressScene> createState() => _AddressSceneState();
}

class _AddressSceneState extends State<ViewAddressScene> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fieldController.text = widget.data;
    nameController.text = widget.data.name;
    addressController.text = widget.data.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Address Info"),
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
              decoration: inputDecoration("Address Name"),
              controller: nameController,
              readOnly: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              decoration: inputDecoration("New Address"),
              controller: addressController,
              minLines: 5,
              maxLines: 10,
              readOnly: true,
            ),
          ),
          RoundedButton(
            text: "Edit",
            press: () {
              //for pop current scene
              Navigator.pop(context);
              //for pop address list scene (coz no update)
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditAddressScene(addressData: widget.data)));
            },
          ),
        ],
      ),
    );
  }
}


