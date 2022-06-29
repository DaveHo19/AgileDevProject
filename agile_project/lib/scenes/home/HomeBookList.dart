import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/scenes/product/ViewProductScene.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/enumList.dart';
import '../product/ViewProductScene.dart';

class HomeBookList extends StatefulWidget {
  const HomeBookList({Key? key}) : super(key: key);

  @override
  State<HomeBookList> createState() => _HomeBookListState();
}

class _HomeBookListState extends State<HomeBookList> {
  List<Widget> layoutList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    layoutInitialize();
    return ListView.builder(
      itemCount: layoutList.length,
      itemBuilder: (context, index) {
        return layoutList[index];
      },
    );
  }

  Widget _buildFantasyRow() {
    final book = Provider.of<List<Book>>(context);
    List<Book> tempList = [];
    if (book.isNotEmpty) {
      for (int i = 0; i < book.length; i++) {
        if (book[i].tags.contains("Fantasy")) {
          tempList.add(book[i]);
        }
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

  Widget _buildNotFantasyRow() {
    final book = Provider.of<List<Book>>(context);
    List<Book> tempList = [];
    if (book.isNotEmpty) {
      for (int i = 0; i < book.length; i++) {
        if (!book[i].tags.contains("Fantasy")) {
          tempList.add(book[i]);
        }
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

  Widget _buildSpace() {
    return const SizedBox(height: 50);
  }

  void layoutInitialize() {
    layoutList.clear();
    layoutList.add(_buildSpace());
    layoutList.add(_buildFantasyRow());
    layoutList.add(_buildSpace());
    layoutList.add(_buildNotFantasyRow());
    layoutList.add(_buildSpace());
    layoutList.add(_buildFantasyRow());
    layoutList.add(_buildSpace());
    layoutList.add(_buildFantasyRow());
  }
}
