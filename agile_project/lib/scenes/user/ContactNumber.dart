import 'dart:html';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/user/ProfileScene.dart';
import 'package:agile_project/scenes/user/ProfileBody.dart';
import 'package:agile_project/scenes/user/EditContactNumberBody.dart';

class ContactNumberScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Contact Number"),
      ),
      body: EditContactNumberBody(),
    );
  }
}
