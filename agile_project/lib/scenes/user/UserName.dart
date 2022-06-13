import 'package:agile_project/models/rounded_button.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/sharedProperties/textField.dart';
import 'package:agile_project/services/databaseService.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Name"),
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
    DatabaseService dbService = DatabaseService();
    dynamic result =
        await dbService.updateUserName(widget.uid, fieldController.text);
    if (result == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Sucess")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed")));
    }
  }
}


// class UserNameScene extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Name"),
//       ),
//       body: EditNameBody(),
//     );
//   }
// }
