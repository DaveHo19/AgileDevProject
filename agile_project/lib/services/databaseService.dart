import 'dart:io';
import 'dart:typed_data';

import 'package:agile_project/models/user.dart';
import 'package:agile_project/models/userInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_Storage.dart';
import 'package:agile_project/models/book.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final FirebaseStorage fbStorage = FirebaseStorage.instance;
  final CollectionReference bookCollectionRef = FirebaseFirestore.instance.collection("books");
  final CollectionReference userCollectionRef = FirebaseFirestore.instance.collection("users");

  //constructor
  DatabaseService();

  Future<String> uploadBookCover(Uint8List imgSrc, String bookID) async {
    String url = "";

    try {
      await fbStorage
          .ref("bookCoverImage/$bookID")
          .putData(imgSrc, SettableMetadata(contentType: "image/jpeg"))
          .then((result) async {
        url = await result.ref.getDownloadURL();
      });
    } catch (e) {
      print("Error: ${e.toString()}");
    }

    return url;
  }

  Future createBook(Book newBook) async {
    return await bookCollectionRef.doc(newBook.ISBN_13).set({
      "ISBN_13": newBook.ISBN_13,
      "title": newBook.title,
      "desc": newBook.description,
      "author": newBook.author,
      "publishedDate": newBook.publishedDate,
      "imgCoverUrl": newBook.imageCoverURL,
      "tags": newBook.tags,
      "tradePrice": newBook.tradePrice,
      "retailPrice": newBook.retailPrice,
      "quantity": newBook.quantity,
    });
  }

  Future updateBook(Book updateBook) async {
    return await bookCollectionRef.doc(updateBook.ISBN_13).update({
      "ISBN_13": updateBook.ISBN_13,
      "title": updateBook.title,
      "desc": updateBook.description,
      "author": updateBook.author,
      "publishedDate": updateBook.publishedDate,
      "imgCoverUrl": updateBook.imageCoverURL,
      "tags": updateBook.tags,
      "tradePrice": updateBook.tradePrice,
      "retailPrice": updateBook.retailPrice,
      "quantity": updateBook.quantity,
    });
  }

  Future deleteBook(String ISBN_No) async {
    await fbStorage.ref("bookCoverImage/$ISBN_No").delete();

    return await bookCollectionRef.doc(ISBN_No).delete(); 
  }
  List<Book> bookListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((item) {
      return Book(
        ISBN_13: item.get("ISBN_13") ?? "",
        title: item.get("title") ?? "",
        description: item.get("desc") ?? "",
        author: item.get("author") ?? "",
        publishedDate: item.get("publishedDate").toDate(),
        imageCoverURL: item.get("imgCoverUrl") ?? "",
        tags: item.get("tags").cast<String>(),
        tradePrice: item.get("tradePrice") ?? 0,
        retailPrice: item.get("retailPrice") ?? 0,
        quantity: item.get("quantity") ?? 0,
      );
    }).toList();
  }

  Stream<List<Book>> get books {
    return bookCollectionRef.snapshots().map(bookListFromSnapshot);
  }

  Future<bool> checkBookExists(String bookNo) async {
    bool result = false;
    await bookCollectionRef.doc(bookNo).get().then((doc) => {
          if (doc.exists)
            {
              result = true,
            }
          else
            {
              result = false,
            }
        });
    return result;
  }

  Future createUserProfile(UserInfomation userInfo) async {
    return await userCollectionRef.doc(userInfo.uid).set({
      "uid": userInfo.uid,
      "userName": userInfo.userName,
      "emailAddress": userInfo.emailAddress,
      "accountLevel": userInfo.accountLevel,
      "wishList": userInfo.wishList,
      "address": userInfo.addressMap,
      "orderList": userInfo.orderList,
    });
  }

  Future<UserInfomation> getUserInformation(String uid) async{
    return await userCollectionRef.doc(uid).get().then((value) 
    {
      return UserInfomation(
        uid: value["uid"],
        userName: value["userName"],
        emailAddress: value["emailAddress"],
        accountLevel: value["accountLevel"],
        wishList: value["wishList"],
        addressMap: value["addressMap"],
        orderList: value["orderList"],
      );
    });
  } 
}
