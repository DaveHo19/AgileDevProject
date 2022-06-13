import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/home/HomeBookList.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:provider/provider.dart';

class MyHomeScene extends StatefulWidget {
  const MyHomeScene({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomeScene> createState() => _MyHomeSceneState();
}

class _MyHomeSceneState extends State<MyHomeScene> {
  var user;
  AccountType currAccountType = AccountType.guest;
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
      child: const HomeBookList(),
    );
  }

  List<Book> errorMessage(BuildContext context, var data) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(data.toString())));

    return <Book>[];
  }
}
