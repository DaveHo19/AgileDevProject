import 'dart:html';

import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/scenes/product/ManageProductScene.dart';

class MyStockLevelScene extends StatefulWidget {
  const MyStockLevelScene({Key? key}) : super(key: key);

  @override
  State<MyStockLevelScene> createState() => _MyStockLevelSceneState();
}

class _MyStockLevelSceneState extends State<MyStockLevelScene> {
  List<Book> bookList = [];
  final bookRef = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stock Level"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        actions: const [
          IconButton(
            icon: Icon(Icons.search),
            tooltip: "Search",
            onPressed: null,
          ),
        ],
      ),
      body: Center(
        child: const Text("On progress for retrieve data from firestore"),
      ),
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
    );
  }

  // Widget _generateListView() {
  //   DatabaseService databaseService = DatabaseService();
  //   return FutureBuilder(
  //     future: databaseService.getBookList(),
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         return _buildContent(snapshot);
  //       } else {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }

  // Widget _buildContent(snapshot) {
  //   // List<Book> bookList = [];
  //   bookList = snapshot.data;
  //   // print(bookList.length);
  //   return ListView.builder(
  //       itemCount: bookList.length,
  //       itemBuilder: (context, i) {
  //         return _buildRowItem(bookList[i]);
  //       });
  // }

  // Widget _buildRowItem(Book item) {
  //   return ListTile(
  //     leading: Container(
  //       height: 200,
  //       child: Image.network(item.imageCoverURL, fit: BoxFit.fill),
  //       decoration: const BoxDecoration(color: Colors.black),
  //     ),
  //     title: Text(item.title),
  //     subtitle: Text(item.description ?? ""),
  //     isThreeLine: true,
  //   );
  // }
}
