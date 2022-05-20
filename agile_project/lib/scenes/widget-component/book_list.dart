import 'package:agile_project/models/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookList extends StatefulWidget {
  const BookList({Key? key}) : super(key: key);

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    final book = Provider.of<List<Book>>(context);
    // book.forEach((element) {
    //   print(element.ISBN_13);
    // });

    //use this command in terminal so that the image can be loaded out-> flutter run -d chrome --web-renderer html
    return ListView.builder(
      itemCount: book.length,
      itemBuilder: (context, index) {
        return _buildBookTile(book[index]);
      },
    );
  }

  // Widget _buildBookTile(Book book){
  //   return ListTile(
  //     title: Text(book.ISBN_13),
  //     subtitle: Text(book.author),
  //   );
  // }

  Widget _buildBookTile(Book book) {
    return ListTile(
      leading: Container(
        width: 50,
        height: 200,
        child: Image.network(book.imageCoverURL, fit: BoxFit.fill),
      ),
      title: Text("Book Name: " + book.title),
      subtitle: Text("Quantity: " + book.quantity.toString()),
    );
  }
}
