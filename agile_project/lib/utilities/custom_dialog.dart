import 'package:agile_project/constants.dart';
import 'package:flutter/material.dart';

class CustomDialog{

  CustomDialog();

  Future<bool> confirm_dialog(BuildContext context, String title, String description, {String textForTrue = "Yes", String textForFalse = "No"}) async {
    bool result = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) => (
        AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )
            ),
          content: Container(
            width: 250,
            height: 200,
            padding: const EdgeInsets.all(4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(description)),
                  Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor,
                              ),
                              onPressed: () {
                                result = false;
                                Navigator.pop(context);
                                }, 
                              child: Text(
                                textForFalse,
                                style: const TextStyle(color: kPrimaryLightColor),
                                )),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: kPrimaryColor,
                              ),
                              onPressed: () {
                                result = true;
                                Navigator.pop(context);
                                }, 
                              child: Text(
                                textForTrue,
                                style: const TextStyle(color: kPrimaryLightColor),
                              )),
                          ),
                        ),
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