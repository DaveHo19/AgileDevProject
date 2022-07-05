import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:agile_project/utilities/field_validation.dart';
import 'package:flutter/material.dart';

class UserNameFieldScene extends StatefulWidget {
  const UserNameFieldScene({
    Key? key,
    required this.data,
    required this.uid,
  }) : super(key: key);

  final String uid;
  final String data;

  @override
  State<UserNameFieldScene> createState() => _UserNameFieldSceneState();
}

class _UserNameFieldSceneState extends State<UserNameFieldScene> {
  final TextEditingController fieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fieldController.text = widget.data;
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Name"),
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
              validator: (String? val) =>
                  (val != null && val.isNotEmpty) ? "Enter the Name" : null,
              decoration: inputDecoration("Name"),
            ),
          ),
          RoundedButton(
            text: "Save",
            press: () async {
              updateName();
            },
          ),
        ],
      ),
    );
  }

  void updateName() async {
    if (isFilledAll(fieldController.text)) {
      FieldValidation valid = FieldValidation();
      if (valid.validateName(fieldController.text)) {
        setState(() {
          isLoading = true;
        });
        DatabaseService dbService = DatabaseService();
        dynamic result =
            await dbService.updateUserName(widget.uid, fieldController.text);
        if (result == null) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Updated successfully!")));
          Navigator.pop(context, true);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Opps! Update Failed")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Minimum 5 and maximum 20 characters only!")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("The field cannot be empty!")));
    }
  }

  bool isFilledAll(String fieldController) {
    return ((fieldController.isNotEmpty));
  }
}
