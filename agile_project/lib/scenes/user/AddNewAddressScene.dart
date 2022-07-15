import 'package:agile_project/constants.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:flutter/material.dart';

class NewAddressScene extends StatefulWidget {
  const NewAddressScene({
    Key? key,
    required this.uid,
    required this.addressType,
  }) : super(key: key);

  final String uid;
  final AddressType addressType;
  @override
  State<NewAddressScene> createState() => _NewAddressSceneState();
}

class _NewAddressSceneState extends State<NewAddressScene> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.addressType == AddressType.billing
              ? "Add New Billing Address"
              : "Add New Shipping Address"),
          backgroundColor: kPrimaryColor,
          foregroundColor: kPrimaryLightColor,
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
    Map<String, String> map = {};
    switch (widget.addressType) {
      case AddressType.billing:
        map = await dbService.getBillingAddress(widget.uid);
        break;
      case AddressType.shipping:
        map = await dbService.getShippingAddress(widget.uid);
    }

    if (isFilledAll(nameController.text, addressController.text)) {
      if (validateName(nameController.text)) {
        if (!map.containsKey(nameController.text)) {
          map[nameController.text] = addressController.text;
          dynamic result;
          switch (widget.addressType) {
            case AddressType.billing:
              result =
                  await dbService.updateUserBillingAddress(widget.uid, map);
              break;
            case AddressType.shipping:
              result =
                  await dbService.updateUserShippingAddress(widget.uid, map);
          }

          if (result == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Updated Successfully!")));
            Navigator.pop(context, true);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Opps! Update Failed")));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("The address name is already exitst!")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "The address name must be contain 5-20 characters only!")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("The field cannot be empty!")));
    }
  }

  bool validateName(String nameController) {
    return RegExp(r"^(?=[a-zA-Z0-9]{5,20}$)").hasMatch(nameController);
  }

  bool isFilledAll(String nameController, String addressController) {
    return ((nameController.isNotEmpty) && (addressController.isNotEmpty));
  }
}
