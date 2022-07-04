import 'package:agile_project/constants.dart';
import 'package:agile_project/models/order.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/product/OrderInfoList.dart';
import 'package:agile_project/services/databaseService.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class MyOrderListScene extends StatefulWidget {
  const MyOrderListScene({
    Key? key}) : super(key: key);

  @override
  State<MyOrderListScene> createState() => _MyOrderListSceneState();
}

class _MyOrderListSceneState extends State<MyOrderListScene> {
  AppUser? user;
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<OrderInfo>>.value(
      value: DatabaseService().orders, 
      initialData: const [],
      catchError: (_, err) => errorMessage(context, err),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Order History"),
          backgroundColor: kPrimaryColor,
          foregroundColor: kPrimaryLightColor
        ),
        body: const OrderInfoList(),
      ),
      );
  }

  List<OrderInfo> errorMessage(BuildContext context, var data) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(data.toString())));

    return [];
  }

}