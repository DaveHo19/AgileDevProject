import 'package:agile_project/models/book.dart';
import 'package:flutter/material.dart';


void main() => runApp(const TestWishlistScene());

class TestWishlistScene extends StatefulWidget {
  const TestWishlistScene({Key? key}) : super(key: key);

  @override
  State<TestWishlistScene> createState() => _TestWishlistSceneState();
}

class _TestWishlistSceneState extends State<TestWishlistScene> {

  List<String> wishlist = [];
  Book bookItems = Book(
    ISBN_13: "1234567890", 
    title: "Debug-Purpose", 
    author: "Debug-Purpose", 
    publishedDate: DateTime.now(), 
    imageCoverURL: "Debug-Purpose", 
    tags: ["Debug", "Debug", "Debug"], 
    tradePrice: 6.66, 
    retailPrice: 7.77, 
    quantity: 6); 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Wishlist"),
        actions: [
          IconButton(
            tooltip: "wishlist_button",
            onPressed: () {
              wishlist.contains(bookItems.ISBN_13) ? wishlist.remove(bookItems.ISBN_13) : wishlist.add(bookItems.ISBN_13); 
            },
            icon: const Icon(Icons.favorite),
          )
        ],
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent(){
    //This should be displaying the UI for Book
    return Container(
      child: Text(wishlist.length.toString()),
    ); 
  }
}

