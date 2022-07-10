import 'dart:typed_data';

import 'package:agile_project/models/enumList.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/utilities/field_validation.dart';

void main() {
  FieldValidation field_validation = FieldValidation();

  //check when the book management status is create
  test(
      "To test the field validations in create book scene, the validations field will be test is \nbook tags = [A, B, C]\ntrade price = 1\nretail price = 1\nbook quantity = 5 \nimage src = [1,2,3,4,5,6,7,8]\nbook management status = Create; \nThe expected result is true",
      () {
    List<String> category = ["A", "B", "C"];
    double tradePrice = 1, retailPrice = 1;
    int quantity = 5;
    Uint8List? imgSrc = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
    BookManagement bm = BookManagement.create;

    expect(
        field_validation.bookFieldValidation(
            category, tradePrice, retailPrice, quantity, imgSrc, bm),
        true);
  });

  test(
      "To test the field validations in create book scene, the validations field will be test is \nbook tags = []\ntrade price = 1\nretail price = 1\nbook quantity = 5 \nimage src = [1,2,3,4,5,6,7,8]\nbook management status = Create; \nThe expected result is false",
      () {
    List<String> category = [];
    double tradePrice = 1, retailPrice = 1;
    int quantity = 5;
    Uint8List? imgSrc = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
    BookManagement bm = BookManagement.create;

    expect(
        field_validation.bookFieldValidation(
            category, tradePrice, retailPrice, quantity, imgSrc, bm),
        false);
  });

  test(
      "To test the field validations in create book scene, the validations field will be test is \nbook tags = [A, B, C]\ntrade price = 1\nretail price = 0\nbook quantity = 5 \nimage src = [1,2,3,4,5,6,7,8]\nbook management status = Create; \nThe expected result is false",
      () {
    List<String> category = ["A", "B", "C"];
    double tradePrice = 1, retailPrice = 0;
    int quantity = 5;
    Uint8List? imgSrc = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
    BookManagement bm = BookManagement.create;

    expect(
        field_validation.bookFieldValidation(
            category, tradePrice, retailPrice, quantity, imgSrc, bm),
        false);
  });  

  test(
      "To test the field validations in create book scene, the validations field will be test is \nbook tags = [A, B, C]\ntrade price = 1\nretail price = 1\nbook quantity = 50 \nimage src = [1,2,3,4,5,6,7,8]\nbook management status = Create; \nThe expected result is false",
      () {
    List<String> category = ["A", "B", "C"];
    double tradePrice = 1, retailPrice = 1;
    int quantity = 50;
    Uint8List? imgSrc = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
    BookManagement bm = BookManagement.create;

    expect(
        field_validation.bookFieldValidation(
            category, tradePrice, retailPrice, quantity, imgSrc, bm),
        false);
  });

  test(
      "To test the field validations in create book scene, the validations field will be test is \nbook tags = [A, B, C]\ntrade price = 1\nretail price = 1\nbook quantity = 5 \nimage src = null\nbook management status = Create; \nThe expected result is false",
      () {
    List<String> category = ["A", "B", "C"];
    double tradePrice = 1, retailPrice = 1;
    int quantity = 5;
    Uint8List? imgSrc;
    BookManagement bm = BookManagement.create;

    expect(
        field_validation.bookFieldValidation(
            category, tradePrice, retailPrice, quantity, imgSrc, bm),
        false);
  });
  //check when the book management status is edit
    test(
      "To test the field validations in edit book scene, the validations field will be test is \nbook tags = [A, B, C]\ntrade price = 1\nretail price = 1\nbook quantity = 5 \nimage src = [1,2,3,4,5,6,7,8]\nbook management status = Edit; \nThe expected result is true",
      () {
    List<String> category = ["A", "B", "C"];
    double tradePrice = 1, retailPrice = 1;
    int quantity = 5;
    Uint8List? imgSrc = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
    BookManagement bm = BookManagement.edit;

    expect(
        field_validation.bookFieldValidation(
            category, tradePrice, retailPrice, quantity, imgSrc, bm),
        true);
  });

  test(
      "To test the field validations in edit book scene, the validations field will be test is \nbook tags = []\ntrade price = 1\nretail price = 1\nbook quantity = 5 \nimage src = [1,2,3,4,5,6,7,8]\nbook management status = Edit; \nThe expected result is false",
      () {
    List<String> category = [];
    double tradePrice = 1, retailPrice = 1;
    int quantity = 5;
    Uint8List? imgSrc = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
    BookManagement bm = BookManagement.edit;

    expect(
        field_validation.bookFieldValidation(
            category, tradePrice, retailPrice, quantity, imgSrc, bm),
        false);
  });

  test(
      "To test the field validations in edit book scene, the validations field will be test is \nbook tags = [A, B, C]\ntrade price = 1\nretail price = 0\nbook quantity = 5 \nimage src = [1,2,3,4,5,6,7,8]\nbook management status = Edit; \nThe expected result is false",
      () {
    List<String> category = ["A", "B", "C"];
    double tradePrice = 1, retailPrice = 0;
    int quantity = 5;
    Uint8List? imgSrc = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
    BookManagement bm = BookManagement.edit;

    expect(
        field_validation.bookFieldValidation(
            category, tradePrice, retailPrice, quantity, imgSrc, bm),
        false);
  });  

  test(
      "To test the field validations in edit book scene, the validations field will be test is \nbook tags = [A, B, C]\ntrade price = 1\nretail price = 1\nbook quantity = 50 \nimage src = [1,2,3,4,5,6,7,8]\nbook management status = Edit; \nThe expected result is false",
      () {
    List<String> category = ["A", "B", "C"];
    double tradePrice = 1, retailPrice = 1;
    int quantity = 50;
    Uint8List? imgSrc = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
    BookManagement bm = BookManagement.edit;

    expect(
        field_validation.bookFieldValidation(
            category, tradePrice, retailPrice, quantity, imgSrc, bm),
        false);
  });

  test(
      "To test the field validations in edit book scene, the validations field will be test is \nbook tags = [A, B, C]\ntrade price = 1\nretail price = 1\nbook quantity = 5 \nimage src = null\nbook management status = Edit; \nThe expected result is true",
      () {
    List<String> category = ["A", "B", "C"];
    double tradePrice = 1, retailPrice = 1;
    int quantity = 5;
    Uint8List? imgSrc;
    BookManagement bm = BookManagement.edit;

    expect(
        field_validation.bookFieldValidation(
            category, tradePrice, retailPrice, quantity, imgSrc, bm),
        true);
  });


}
