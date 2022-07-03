import 'package:agile_project/models/order.dart';
import 'package:agile_project/scenes/product/ViewOrderDetails.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderInfoList extends StatefulWidget {
  const OrderInfoList({Key? key}) : super(key: key);

  @override
  State<OrderInfoList> createState() => _OrderInfoListState();
}

//the order list arrange in ascending order of date added
List<OrderInfo> list = [];

class _OrderInfoListState extends State<OrderInfoList> {
  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<List<OrderInfo>>(context);
    if (orderList.isNotEmpty) {
      orderList.sort((a, b) => a.orderDate.compareTo(b.orderDate));
      list = orderList.reversed.toList();
    }
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, i) {
          return buildOrderTile(list[i]);
        });
  }

//user order with details and total price to be pay (book price + delievry fee)
  Widget buildOrderTile(OrderInfo order) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        title: Text("Order CodeL ${order.orderCode}"),
        subtitle: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                  child: Text(
                      "Total Payment : ${(order.orderItemPrices + order.deliveryFee).toStringAsFixed(2)}")),
              Expanded(
                  child: Text(
                      "Date: ${DateFormat('yyyy-MM-dd').format(order.orderDate)}")),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyViewOrderDetails(
                        orderInfoData: order,
                      )));
        },
      ),
    );
  }
}
