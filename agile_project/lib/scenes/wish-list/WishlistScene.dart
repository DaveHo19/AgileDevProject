import 'package:agile_project/models/book.dart';
import 'package:agile_project/models/user.dart';
import 'package:agile_project/scenes/admin-only/StockLevelBooksList.dart';
import 'package:agile_project/scenes/product/ViewProductScene.dart';
import 'package:agile_project/scenes/sharedProperties/loadingBox.dart';
import 'package:agile_project/services/databaseService.dart';
import 'package:agile_project/utilities/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:agile_project/models/enumList.dart';
import 'package:provider/provider.dart';

class MyWishlistScene extends StatefulWidget {
  const MyWishlistScene({
    Key? key,
  }) : super(key: key);

  @override
  State<MyWishlistScene> createState() => _MyWishlistSceneState();
}

class _MyWishlistSceneState extends State<MyWishlistScene> {
  AppUser? user;
  List<Book> bookWishList = [];
  List<String> bookISBNWishList = [];
  bool isProcess = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //to identify login or not
    user = Provider.of<AppUser?>(context);
    return Container(
        child: (user == null)
            ? const Center(
                child: Text("No user login!"),
              )
            : isProcess
                ? const Loading()
                : FutureBuilder(
                    future: initialWishList(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Loading();
                      } else {
                        return buildWishListView();
                      }
                    },
                  ));
  }

//add book into wishlist
  Widget buildWishListView() {
    return RefreshIndicator(
      onRefresh: refreshContent,
      child: ListView.builder(
        itemCount: bookWishList.isEmpty ? 0 : bookWishList.length,
        itemBuilder: (context, i) {
          return buildListViewItem(bookWishList[i]);
        },
      ),
    );
  }

  Widget buildListViewItem(Book item) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey))),
        child: (item.title.isNotEmpty)
            ? ListTile(
                leading: Container(
                  width: 50,
                  height: 200,
                  child: Image.network(
                    item.imageCoverURL,
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text("Book Name: ${item.title}"),
                onTap: () {
                  goToBook(item);
                },
                onLongPress: () {
                  deleteProcess(item);
                },

                //if the book has been deleted from stock, book in wishlist will also be deleted
              )
            : ListTile(
                title: Text("ISBN NO: ${item.ISBN_13}"),
                subtitle: const Text(
                    "This book been removed from stock. Press me to delete the item from wishlist!"),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("This book is removed from stock!")));
                },
                onLongPress: () {
                  deleteProcess(item);
                },
              ),
      ),
    );
  }

  Future refreshContent() async {
    setState(() => initialWishList());
  }

  Future initialWishList() async {
    if (user != null) {
      DatabaseService dbService = DatabaseService();
      bookISBNWishList = await dbService.getUserWishlist(user!.uid);
      if (bookISBNWishList.isNotEmpty) {
        bookWishList =
            await dbService.getBookListByBookISBNList(bookISBNWishList);
      }
      ;
    }
  }

  void goToBook(Book book) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyViewProductScene(
                book: book, viewManagement: ViewManagement.public)));
  }

//remove book from wishlist
  void deleteProcess(Book book) async {
    CustomDialog customDialog = CustomDialog();
    String dialogContent = book.title.isEmpty
        ? "Remove this invalid book from your wishlist?"
        : "Are you sure to remove this book from your wishlist?";
    DatabaseService dbService = DatabaseService();
    if (user != null) {
      isProcess = true;
      bool result = await customDialog.confirm_dialog(
          context, "Confirmation Dialog", dialogContent);
      if (result) {
        if (bookISBNWishList.contains(book.ISBN_13)) {
          bookISBNWishList.remove(book.ISBN_13);
          dynamic res =
              await dbService.updateUserWishlist(user!.uid, bookISBNWishList);
          if (res == null) {
            isProcess = false;
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Removed!")));
          } else {
            isProcess = false;
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to Remove!")));
          }
        }
      }
    }
  }
}
