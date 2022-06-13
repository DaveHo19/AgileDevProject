import 'dart:html';
import 'package:flutter/material.dart';
import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';

class ContactNumberScene extends StatefulWidget {
  const ContactNumberScene({
    Key? key,
    required this.data,
    required this.uid,
  }) : super(key: key);

  final String uid;
  final String data;

  @override
  State<ContactNumberScene> createState() => _ContactNumberSceneState();
}

class _ContactNumberSceneState extends State<ContactNumberScene> {
  final TextEditingController fieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fieldController.text = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Contact Number"),
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
              controller: fieldController,
              validator: (String? val) => (val != null && val.isNotEmpty)
                  ? "Enter the Contact Number"
                  : null,
              decoration: inputDecoration("Contact Number"),
            ),
          ),
          RoundedButton(
            text: "Save",
            press: () async {
              updatePhone();
            },
          ),
        ],
      ),
    );
  }

  void updatePhone() async {
    DatabaseService dbService = DatabaseService();
    dynamic result =
        await dbService.updatePhoneNumber(widget.uid, fieldController.text);
    if (result == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Sucess")));
          Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed")));
    }
  }
}

// class ContactNumberScene extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Contact Number"),
//       ),
//       body: EditContactNumberBody(),
//     );
//   }
// }