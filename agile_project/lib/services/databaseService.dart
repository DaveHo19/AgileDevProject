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
}