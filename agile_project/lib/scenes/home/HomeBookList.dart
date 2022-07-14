import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:agile_project/scenes/product/ViewProductScene.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/category.dart';
import '../../models/enumList.dart';
import '../product/ViewProductScene.dart';

class HomeBookList extends StatefulWidget {
  const HomeBookList({Key? key}) : super(key: key);

  @override
  State<HomeBookList> createState() => _HomeBookListState();
}

class _HomeBookListState extends State<HomeBookList> {
  TextEditingController searchController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  List<Widget> layoutList = [];
  List<String> category = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    searchController.addListener(() {
      _onSearchChanged;
      setState(() {});
    });

    categoryController.addListener(() {
      _onSearchChangedCategory();
      setState(() {});
    });
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

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    categoryController.removeListener(_onSearchChangedCategory);
    categoryController.dispose();
    searchController.dispose();
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

  Widget _buildSearchTitle() {
    final book = Provider.of<List<Book>>(context);
    List<Book> tempList = [];
    if (book.isNotEmpty) {
      for (int i = 0; i < book.length; i++) {
        if (book[i]
            .title
            .toLowerCase()
            .contains(searchController.text.toString().toLowerCase())) {
          tempList.add(book[i]);
        }
      }
    }
    if (tempList.length == 0) {
      return Center(child: Text("There is no match book title found!"));
    } else {
      return SizedBox(
        height: 600,
        child: ListView.builder(
          itemCount: tempList.length,
          itemBuilder: (context, index) => _buildBookTile(tempList[index]),
        ),
      );
    }
  }

  Widget _buildSearchCategory() {
    final book = Provider.of<List<Book>>(context);
    List<Book> tempList = [];
    final split_tag = categoryController.text.toString().split(";");
    if (book.isNotEmpty) {
      for (int i = 0; i < book.length; i++) {
        for (int j = 0; j < (split_tag.length - 1); j++) {
          if (!tempList.contains(book[i].ISBN_13)) {
            if (book[i].tags.contains(split_tag[j].trim())) {
              tempList.add(book[i]);
            }
          }
        }
      }
      tempList = tempList.toSet().toList();
    }
    if (tempList.length == 0) {
      return Center(
          child:
              Text("There is no match book with the selected category found!"));
    } else {
      return SizedBox(
        height: 600,
        child: ListView.builder(
          itemCount: tempList.length,
          itemBuilder: (context, index) => _buildBookTile(tempList[index]),
        ),
      );
    }
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
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Book Title",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.black)),
          ),
          readOnly: checkReadOnlyBool(categoryController.text.length)),
    );
  }

  void _callMultiSelectDialog() {
    List<String> categoryList = getCategoryList();
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            StatefulBuilder(builder: (context, setState) {
              return (AlertDialog(
                title: const Text("Categories"),
                content: Container(
                  width: (MediaQuery.of(context).size.width / 3) * 2,
                  height: (MediaQuery.of(context).size.height / 2),
                  padding: const EdgeInsets.all(4),
                  child: ListView.builder(
                      itemCount: categoryList.length,
                      itemBuilder: (context, index) {
                        return _categoryRow(categoryList[index]);
                      }),
                ),
                actions: [
                  Center(
                    child: TextButton(
                        onPressed: () {
                          setState(
                            () {
                              category.clear();
                              categoryController.text = "";
                            },
                          );
                        },
                        child: Text("Reset Category")),
                  )
                ],
              ));
            }));
  }

  Widget _buildCategoryField(String fieldName) {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Book Category",
          suffixIcon: IconButton(
            onPressed: _callMultiSelectDialog,
            icon: const Icon(Icons.list),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.black)),
        ),
        readOnly: true,
        controller: categoryController,
      ),
    );
  }

  Widget _categoryRow(String items) {
    bool added = category.contains(items);
    return StatefulBuilder(builder: (context, setState) {
      return ListTile(
        subtitle: Text(items),
        trailing: Checkbox(
          value: added,
          onChanged: (val) => setState(
            () {
              added = val ?? false;
              added ? category.add(items) : category.remove(items);
              categoryController.text = "";
              if (category.isNotEmpty) {
                for (int i = 0; i < category.length; i++) {
                  categoryController.text += category[i] + "; ";
                }
              }
            },
          ),
        ),
      );
    });
  }

  bool checkReadOnlyBool(int i) {
    if (i == 0) {
      return false;
    } else {
      return true;
    }
  }

  _onSearchChanged() {
    print(searchController.text);
  }

  _onSearchChangedCategory() {
    print(categoryController.text);
  }

  void layoutInitialize() {
    if (searchController.text.length == 0 &&
        categoryController.text.length == 0) {
      layoutList.clear();
      layoutList.add(_buildSearchBox());
      layoutList.add(_buildCategoryField("Book Category"));
      layoutList.add(_buildSpace());
      layoutList.add(_buildFantasyRow());
      layoutList.add(_buildSpace());
      layoutList.add(_buildNotFantasyRow());
      layoutList.add(_buildSpace());
      layoutList.add(_buildFantasyRow());
      layoutList.add(_buildSpace());
      layoutList.add(_buildFantasyRow());
    } else if (searchController.text.length > 0) {
      layoutList.clear();
      layoutList.add(_buildSearchBox());
      layoutList.add(_buildSpace());
      layoutList.add(_buildSearchTitle());
    } else if (categoryController.text.length > 0) {
      layoutList.clear();
      layoutList.add(_buildCategoryField("Book Category"));
      layoutList.add(_buildSpace());
      layoutList.add(_buildSearchCategory());
    }
  }
}
