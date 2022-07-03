import 'dart:html';
import 'package:agile_project/constants.dart';
import 'package:agile_project/models/order.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/product/ViewOrderDetails.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/scenes/user/OrderBody.dart';
import 'package:agile_project/scenes/user/ProfileMenu.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MyOrderListScene extends StatefulWidget {
  const MyOrderListScene({Key? key}) : super(key: key);

  @override
  State<MyOrderListScene> createState() => _MyOrderListSceneState();
}

class _MyOrderListSceneState extends State<MyOrderListScene> {
  AppUser? user;
  List<String> orderCodeList = [];
  List<OrderInfo> orderInfoList = [];

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AppUser?>(context);
    return FutureBuilder(
        future: initialOrderList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Loading();
          } else {
            return buildListView();
          }
        });
  }

//prompt message when user check order list but there is no order made yet
  Widget buildListView() {
    return Scaffold(
        appBar: AppBar(
          title: const Text("My Order"),
          backgroundColor: kPrimaryColor,
          foregroundColor: kPrimaryLightColor,
        ),
        body: orderInfoList.isNotEmpty
            ? ListView.builder(
                itemCount: orderInfoList.length,
                itemBuilder: (context, i) {
                  return buildListItem(orderInfoList[i]);
                })
            : const Center(
                child: Text("You have not make any order yet!"),
              ));
  }

  Widget buildListItem(OrderInfo order) {
    return ProfileMenu(
        text: order.orderCode!,
        press: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MyViewOrderDetails(orderInfoData: order)));
        },
        icons: const Icon(Icons.inventory_2),
        value: DateFormat('yyyy-MM-dd').format(order.orderDate));
  }

  Future initialOrderList() async {
    DatabaseService dbService = DatabaseService();
    if (user != null) {
      orderCodeList = await dbService.getOrderList(user!.uid);
      print(orderCodeList);
      orderInfoList =
          await dbService.getOrderListByOrderCodeList(orderCodeList);
      print(orderInfoList);
      if (orderInfoList.isNotEmpty) {
        orderInfoList.sort((a, b) => a.orderDate.compareTo(b.orderDate));
        orderInfoList = orderInfoList.reversed.toList();
      }
    }
  }
}
