// import 'dart:html';
// import 'dart:io';

// import 'package:agile_project/scenes/user/AddressInformation';
// import 'package:agile_project/scenes/user/AddressBody.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class BillingAddress extends StatelessWidget{
//   const BillingAddress({Key? key}) : super(key: key);

//   @override

//   Widget build (BuildContext context) {
//     return Column(
//       bool_isEditingText = false;
//       TextEditingController_editingController;
//       String initialText = "Input Your Address Here";

//     )
//   }

// @override
// void initState() {

//   super.initState();
//   _editingController = TextEditingController(text: initialText);
// }
// @override
// void dispose (){
//   _editingController.dispose();
//   super.dispose();
// }

// @override
// Widget build (BuildContext context){

//   return Scaffold(
//     appBar: AppBar(
//       title: Text ("Editable Text"),
//     ),

//     body: Center
//     (child: _editTitleTextField()
//     ),
//   ),
// }

// Widget _editTitleTextField(){
//   if (_isEditingText)
//   return Center(
//     child: TextField(
//       onSubmitted: (newValue){
//         setState((){
//           initialText = newValue;
//           _isEditingText = false;
//         });
//       },

//     ),
//   )
// }
// }