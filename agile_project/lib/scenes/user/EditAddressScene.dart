import 'package:agile_project/models/address.dart';
import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAddressScene extends StatefulWidget {
  const EditAddressScene({
    Key? key,
    required this.addressData}) : super(key: key);
  
  final BillingAddress addressData; 
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
  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    initialAddress();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
    if (user != null){
      addressMap = await dbService.getBillingAddress(user!.uid);
    }
  }

  void updateAddress() async {
    DatabaseService dbService = DatabaseService();
    
    if ((widget.addressData.name != nameController.text) && (addressMap.containsKey(nameController.text))){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("The address name is already exists!")));
    } else{
      addressMap.remove(widget.addressData.name);
      addressMap[nameController.text] = addressController.text;
      if (user != null){
        dynamic result = await dbService.updateUserBillingAddress(user!.uid, addressMap);
        if (result == null){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Updated!")));
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Failed to update!")));
        }
      } 
    }
    
    
     
  }
}