import 'dart:html';

import 'package:agile_project/constants.dart';
import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/scenes/admin-only/StockLevelBooksList.dart';
import 'package:agile_project/scenes/product/OrderListScene.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/product/ManageProductScene.dart';

class MyStockLevelScene extends StatefulWidget {
  const MyStockLevelScene({Key? key}) : super(key: key);

  @override
  State<MyStockLevelScene> createState() => _MyStockLevelSceneState();
}

class _MyStockLevelSceneState extends State<MyStockLevelScene> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Book>>.value(
      value: DatabaseService().books,
      initialData: const [],
      catchError: (_, error) => errorMessage(context, error),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Stock Level"),
          backgroundColor: kPrimaryColor,
          foregroundColor: kPrimaryLightColor,
          actions: [
            const IconButton(
              icon: Icon(Icons.search),
              tooltip: "Search",
              onPressed: null,
            ),
            PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(
                      value: 0,
                      child: Text("Order List"),
                    ),
                  ];
                },
                onSelected: (int i) => {
                      menuItemHandler(context, i),
                    })
          ],
        ),
        body: const BookList(),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyManageProductScene(
                          bookManagement: BookManagement.create,
                        )));
          },
          icon: const Icon(Icons.add),
          label: const Text("Add Stock"),
        ),
      ),
    );
  }

  List<Book> errorMessage(BuildContext context, var data) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(data.toString())));

    return <Book>[];
  }

  void menuItemHandler(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MyOrderListScene()));
        break;
    }
  }
}
