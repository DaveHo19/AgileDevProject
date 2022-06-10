import 'package:flutter/material.dart';



InputDecoration inputDecoration(String title) => InputDecoration( 
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 2.0
      ),
    ),
    labelText: title,
    hintText: "Enter $title",
    floatingLabelBehavior: FloatingLabelBehavior.always,
    floatingLabelAlignment: FloatingLabelAlignment.start,
);

InputDecoration dateInputDecoration(String title) => InputDecoration(
    border: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 2.0
      ),
    ),
    labelText: title,
    hintText: "Select $title",
    floatingLabelBehavior: FloatingLabelBehavior.always,
    floatingLabelAlignment: FloatingLabelAlignment.start,
);

