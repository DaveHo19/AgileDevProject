import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/scenes/product/SearchBookScene.dart';
import 'package:agile_project/scenes/product/ViewProductScene.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
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
  TextEditingController _searchController = TextEditingController();
  List<Widget> layoutList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: layoutInitialize(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Loading();
          } else {
            return buildContent();
          }
        });
  }

  Widget buildContent() {
    return ListView.builder(
      itemCount: layoutList.length,
      itemBuilder: (context, index) {
        return layoutList[index];
      },
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
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

  Widget _buildsearchRow() {
    final book = Provider.of<List<Book>>(context);
    List<Book> tempList = [];
    if (book.isNotEmpty) {
      for (int i = 0; i < book.length; i++) {
        if (book[i]
            .title
            .toLowerCase()
            .contains(_searchController.text.toString().toLowerCase())) {
          tempList.add(book[i]);
        }
      }
    }
    return SizedBox(
      height: 600,
      child: ListView.builder(
        itemCount: tempList.length,
        itemBuilder: (context, index) => _buildBookTile(tempList[index]),
      ),
    );
  }

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
                      viewManagement: ViewManagement.public, book: book)));
        },
        enabled: true,
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

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Book Title",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black)),
        ),
      ),
    );
  }

  // Widget _buildSearchBox() {
  //   return Container(
  //     padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
  //     child: FloatingActionButton.extended(
  //       heroTag: "SearchBtn",
  //       label: Text('Search Book'), // <-- Text
  //       backgroundColor: Colors.black,
  //       icon: Icon(
  //         // <-- Icon
  //         Icons.search,
  //         size: 24.0,
  //       ),
  //       onPressed: () {
  //         Navigator.of(context)
  //             .push(MaterialPageRoute(builder: (context) => SearchBookScene()));
  //       },
  //     ),
  //   );
  // }

  _onSearchChanged() {
    print(_searchController.text.length);
  }

  Future layoutInitialize() async {
    if (_searchController.text.length == 0) {
      layoutList.clear();
      layoutList.add(_buildSearchBox());
      layoutList.add(_buildSpace());
      layoutList.add(_buildFantasyRow());
      layoutList.add(_buildSpace());
      layoutList.add(_buildNotFantasyRow());
      layoutList.add(_buildSpace());
      layoutList.add(_buildFantasyRow());
      layoutList.add(_buildSpace());
      layoutList.add(_buildFantasyRow());
      //layoutList.add(_buildRemainRow());
    } else {
      layoutList.clear();
      layoutList.add(_buildSearchBox());
      layoutList.add(_buildSpace());
      layoutList.add(_buildsearchRow());
    }
  }
}
