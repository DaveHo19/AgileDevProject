import 'package:agile_project/models/book.dart';
import 'package:agile_project/scenes/widget-component/book_list.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebugRetrieve extends StatefulWidget {
  const DebugRetrieve({ Key? key }) : super(key: key);

  @override
  State<DebugRetrieve> createState() => _DebugRetrieveState();
}

class _DebugRetrieveState extends State<DebugRetrieve> {

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Book>>.value(
      value: DatabaseService().books, 
      initialData: const [],
      catchError: (_, error) => errorMessage(context, error),
        child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Debug Retrieve'),
          elevation: 0.0,
        ),
      body: const BookList(),
      ),);
  }
}

List<Book> errorMessage(BuildContext context, var data){

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(data.toString()))
  );

  return <Book>[];
}



