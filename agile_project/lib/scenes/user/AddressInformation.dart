import 'dart:html';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/user/ProfileScene.dart';
import 'package:agile_project/scenes/user/AddressBody.dart';

class MyAddressScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Addresses"),
      ),
      body: AddressBody(),
    );
  }
}
