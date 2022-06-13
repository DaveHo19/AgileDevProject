import 'package:agile_project/models/book.dart';
import 'package:flutter/material.dart';

class CustomDialog{

  CustomDialog();

  Future<bool> confirm_dialog(BuildContext context, String title, String description, {String textForTrue = "Yes", String textForFalse = "No"}) async {
    bool result = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) => (
        AlertDialog(
          title: Text(title),
          content: Container(
            width: 250,
            height: 200,
            padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Text(description)),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            result = false;
                            Navigator.pop(context);
                            }, 
                          child: Text(textForFalse)),
                        ElevatedButton(
                          onPressed: () {
                            result = true;
                            Navigator.pop(context);
                            }, 
                          child: Text(textForTrue)),
                      ],
                    ),
                  )
                ],),
            )
          )
        ));
    return result;
  }  
}