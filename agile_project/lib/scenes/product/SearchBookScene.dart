import 'package:agile_project/constants.dart';
import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/scenes/product/ViewProductScene.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/enumList.dart';
import '../product/ViewProductScene.dart';

class SearchBookScene extends StatefulWidget {
  const SearchBookScene({Key? key}) : super(key: key);

  @override
  State<SearchBookScene> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBookScene> {
  TextEditingController _searchController = TextEditingController();
  List<Widget> layoutList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search Book Scene"),
          backgroundColor: kPrimaryColor,
          foregroundColor: kPrimaryLightColor,
        ),
        body: _buildAllBook());
  }

  Widget _buildAllBook() {
    final book = Provider.of<List<Book>>(context);
    List<Book> tempList = [];
    if (book.isNotEmpty) {
      for (int i = 0; i < book.length; i++) {
        tempList.add(book[i]);
      }
    }
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tempList.length,
        itemBuilder: (context, index) => _buildBook(tempList[index]),
      ),
    );
  }

  Widget _buildBook(Book book) {
    return Container(
      height: 100,
      width: 200,
      child: GestureDetector(
          child: Card(
            elevation: 2,
            child: Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Image.network(
                      book.imageCoverURL,
                      fit: BoxFit.fill,
                    )),
                Expanded(
                  flex: 1,
                  child: Text(
                    book.title,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyViewProductScene(
                        viewManagement: ViewManagement.public, book: book)));
          }),
    );
  }
}
