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
  final CollectionReference bookCollectionRef =
      FirebaseFirestore.instance.collection("books");
  final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection("users");

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

  Future<List<Book>> getBookListByWishlist(List<String> list) async {
    List<Book> bookList = [];

    for (int i = 0; i < list.length; i++) {
      Book book = await getBookByISBN(list.elementAt(i));
      bookList.add(book);
    }
    return bookList;
  }

  Future<Book> getBookByISBN(String bookISBN) async {
    return await bookCollectionRef.doc(bookISBN).get().then((doc) {
      if (doc.exists){
        return Book(
                  ISBN_13: doc.get("ISBN_13") ?? "",
                  title: doc.get("title") ?? "",
                  description: doc.get("desc") ?? "",
                  author: doc.get("author") ?? "",
                  publishedDate: doc.get("publishedDate").toDate(),
                  imageCoverURL: doc.get("imgCoverUrl") ?? "",
                  tags: doc.get("tags").cast<String>(),
                  tradePrice: doc.get("tradePrice") ?? 0,
                  retailPrice: doc.get("retailPrice") ?? 0,
                  quantity: doc.get("quantity") ?? 0);
      } else {
        print("No data");
        return Future.error("No Data");
      } 
    });
  }

  Future createUserProfile(UserInfomation userInfo) async {
    return await userCollectionRef.doc(userInfo.uid).set({
      "uid": userInfo.uid,
      "userName": userInfo.userName,
      "emailAddress": userInfo.emailAddress,
      "gender": userInfo.gender,
      "phoneNumber": userInfo.phoneNumber,
      "accountLevel": userInfo.accountLevel,
      "wishList": List<String>.from(userInfo.wishList),
      "billingAddress": userInfo.billingAddressMap,
      "shippingAddress": userInfo.shippingAddressMap,
      "orderList": userInfo.orderList,
      "carts": userInfo.carts,
    });
  }

  Future<List<String>> getUserWishlist(String uid) async {
    return await userCollectionRef.doc(uid).get().then((doc) {
      return List<String>.from(doc.get("wishList"));
    });
  }

  Future updateUserWishlist(String userID, List<String> newWishList) async {
    return await userCollectionRef.doc(userID).update({
      "wishList": newWishList,
    });
  }

  Future updateUserProfile(UserInfomation userInfo) async {
    return await userCollectionRef.doc(userInfo.uid).update({
      "userName": userInfo.userName,
      "gender": userInfo.gender,
      "phoneNumber": userInfo.phoneNumber,
    });
  }

  Future<Map<String, String>> getBillingAddress(String uid) async {
    return await userCollectionRef.doc(uid).get().then((value) {
      return Map.from(value.get("billingAddress"));
    });
  }

  Future updateUserBillingAddress(
      String userID, Map<String, String> billingAddress) async {
    return await userCollectionRef.doc(userID).update({
      "billingAddress": billingAddress,
    });
  }

  Future<Map<String, String>> getShippingAddress(String uid) async {
    return await userCollectionRef.doc(uid).get().then((value) {
      return Map.from(value.get("shippingAddress"));
    });
  }

  Future updateUserShippingAddress(
      String userID, Map<String, String> shippingAddress) async {
    return await userCollectionRef.doc(userID).update({
      "shippingAddress": shippingAddress,
    });
  }

  Future<Map<String, int>> getCartItems(String uid) async {
    return await userCollectionRef.doc(uid).get().then((value){
      return Map.from(value.get("carts"));
    });
  }

  Future updateUserCartItems(String uid, Map<String, int> cartItems) async {
    return await userCollectionRef.doc(uid).update({"carts" : cartItems});
  }

  Future<UserInfomation> getUserInformation(String uid) async {
    return await userCollectionRef.doc(uid).get().then((value) {
      return UserInfomation(
        uid: value.get("uid"),
        userName: value.get("userName"),
        emailAddress: value.get("emailAddress"),
        gender: value.get("gender"),
        phoneNumber: value.get("phoneNumber"),
        accountLevel: value.get("accountLevel"),
      );
    });
  }

  Future updateUserName(String uid, String val) async {
    return await userCollectionRef.doc(uid).update({
      "userName": val,
    });
  }

  Future updatePhoneNumber(String uid, String val) async {
    return await userCollectionRef.doc(uid).update({
      "phoneNumber": val,
    });
  }
}
