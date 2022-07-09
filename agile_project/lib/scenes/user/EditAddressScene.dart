import 'package:agile_project/constants.dart';
import 'package:agile_project/models/address.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAddressScene extends StatefulWidget {
  const EditAddressScene({
    Key? key,
    required this.addressData,
    required this.addressType,
  }) : super(key: key);

  final LocationAddress addressData;
  final AddressType addressType;
  @override
  State<EditAddressScene> createState() => _EditAddressSceneState();
}

class _EditAddressSceneState extends State<EditAddressScene> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  AppUser? user;
  Map<String, String> addressMap = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.addressData.name;
    addressController.text = widget.addressData.address;
  }

  //address with address name (title: such as Work / Home)
  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    initialAddress();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        backgroundColor: kPrimaryColor,
        title: const Text("Edit Address Info"),
      ),
      body: Center(
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
                updateAddress();
              },
            ),
          ],
        ),
      ),
    );
  }

  void initialAddress() async {
    DatabaseService dbService = DatabaseService();
    if (user != null) {
      switch (widget.addressType) {
        case AddressType.billing:
          addressMap = await dbService.getBillingAddress(user!.uid);
          break;
        case AddressType.shipping:
          addressMap = await dbService.getShippingAddress(user!.uid);
          break;
      }
    }
  }

//update address name with new name
  void updateAddress() async {
    DatabaseService dbService = DatabaseService();
    if ((widget.addressData.name != nameController.text) &&
        (addressMap.containsKey(nameController.text))) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("The address name is already exists!")));
    } else {
      addressMap.remove(widget.addressData.name);
      addressMap[nameController.text] = addressController.text;
      if (user != null) {
        dynamic result;
        switch (widget.addressType) {
          case AddressType.billing:
            result =
                await dbService.updateUserBillingAddress(user!.uid, addressMap);
            break;
          case AddressType.shipping:
            result = await dbService.updateUserShippingAddress(
                user!.uid, addressMap);
            break;
        }

        if (result == null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Updated!")));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Failed to update!")));
        }
      }
    }
  }
    if (isFilledAll(nameController.text, addressController.text)) {
      if (validateName(nameController.text)) {
        DatabaseService dbService = DatabaseService();
        if ((widget.addressData.name != nameController.text) &&
            (addressMap.containsKey(nameController.text))) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("The address name is already exists!")));
        } else {
          addressMap.remove(widget.addressData.name);
          addressMap[nameController.text] = addressController.text;
          if (user != null) {
            dynamic result;
            switch (widget.addressType) {
              case AddressType.billing:
                result = await dbService.updateUserBillingAddress(
                    user!.uid, addressMap);
                break;
              case AddressType.shipping:
                result = await dbService.updateUserShippingAddress(
                    user!.uid, addressMap);
                break;
            }
            if (result == null) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Updated!")));
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Failed to update!")));
            }
          }
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
