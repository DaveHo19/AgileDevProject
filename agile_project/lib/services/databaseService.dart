import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_Storage.dart';
import 'package:agile_project/models/book.dart';
import 'package:flutter/material.dart';


class DatabaseService{

  final FirebaseStorage fbStorage = FirebaseStorage.instance;
  final CollectionReference bookCollectionRef = FirebaseFirestore.instance.collection("books");
  
  //constructor
  DatabaseService();

  Future<String> uploadBookCover(Uint8List imgSrc, String bookID) async {
    String url = "";

    try{
      await fbStorage.ref("bookCoverImage/$bookID").putData(imgSrc, SettableMetadata(contentType: "image/jpeg"))
      .then((result) async{
        url = await result.ref.getDownloadURL();
      });
    } catch (e){
      print("Error: ${e.toString()}");
    }   

    return url;
  }

  Future createBook(Book newBook) async {
    return await bookCollectionRef.doc(newBook.ISBN_13).set(
      {
        "ISBN_13"       : newBook.ISBN_13,
        "title"         : newBook.title,
        "desc"          : newBook.description,
        "author"        : newBook.author,
        "publishedDate" : newBook.publishedDate,
        "imgCoverUrl"   : newBook.imageCoverURL,
        "tags"          : newBook.tags,
        "tradePrice"    : newBook.tradePrice,
        "retailPrice"   : newBook.retailPrice,
        "quantity"      : newBook.quantity,
      }
    );
  }

  List<Book> bookListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((item){
      return Book(
        ISBN_13: item.get("ISBN_13")??"",
        title: item.get("title")??"",
        description: item.get("desc")??"",
        author: item.get("author")??"",
        publishedDate: item.get("publishedDate").toDate(),
        imageCoverURL: item.get("imgCoverUrl")??"",
        tags: item.get("tags").cast<String>(),
        tradePrice: item.get("tradePrice")??0,
        retailPrice: item.get("retailPrice")??0,
        quantity: item.get("quantity")??0,
      );
    }).toList();
  }

  Stream<List<Book>> get books {
    return bookCollectionRef.snapshots().map(bookListFromSnapshot);
  }

  Future<bool> checkBookExists(String bookNo) async {
    bool result = false;
    await bookCollectionRef.doc(bookNo).get().then((doc) => {
      if (doc.exists){
        result = true,
      } else {
        result = false,
      }
    });
    return result;

  }
}