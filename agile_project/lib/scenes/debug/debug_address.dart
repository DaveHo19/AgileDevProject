import 'package:agile_project/models/user.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebugAddress extends StatefulWidget {
  const DebugAddress({Key? key}) : super(key: key);

  @override
  State<DebugAddress> createState() => _DebugAddressState();
}

class _DebugAddressState extends State<DebugAddress> {
  AppUser? user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    return Scaffold(
        appBar: AppBar(title: const Text("Debug Address")),
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                getData();
              },
              child: const Text("Debug")),
        ));
  }

  void getData() async {
    DatabaseService dbService = DatabaseService();
    if (user != null) {
      print(user!.uid);
      Map<String, String> data = await dbService.getBillingAddress(user!.uid);
      if (data.isNotEmpty) {
        for (var key in data.keys) {
          print("${key} : ${data[key]}");
        }
      }
    }
  }
}
