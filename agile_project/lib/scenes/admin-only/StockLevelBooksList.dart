import 'package:agile_project/models/book.dart';
import 'package:agile_project/scenes/product/ViewProductScene.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:agile_project/models/enumList.dart';

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    final book = Provider.of<List<Book>>(context);

    //use this command in terminal so that the image can be loaded out-> flutter run -d chrome --web-renderer html
    return ListView.builder(
      itemCount: book.length,
      itemBuilder: (context, index) {
        return _buildBookTile(book[index]);
      },
    );
  }

  //Container is used to store one or more widgets and position them on the screen
  Widget _buildBookTile(Book book) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 200,
          child: Image.network(book.imageCoverURL, fit: BoxFit.fill),
        ),
        title: Text("Book Name: ${book.title}"),
        subtitle: Text("Quantity: ${book.quantity.toString()}"),
        trailing: const Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyViewProductScene(
                      viewManagement: ViewManagement.private, book: book)));
        },
        enabled: true,
      ),
    );
  }
}
