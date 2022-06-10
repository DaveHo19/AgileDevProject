import 'dart:typed_data';

import 'package:agile_project/models/enumList.dart';

///A public utilities class for field validation
class FieldValidation{
  
  //for creating instances 
  FieldValidation();

  ///To validate the some of the book fields 
  bool bookFieldValidation(List<String> category, double tradePrice, double retailPrice, int quantity, Uint8List? imgSrc, BookManagement bm) {
    return ((category.isNotEmpty) &&
         priceValidation(tradePrice) &&
         priceValidation(retailPrice) &&
         quantityValidation(quantity) &&
        (valueValidation(imgSrc) || (bm == BookManagement.edit)));
  }

  ///To validate the variables contain any value
  bool valueValidation(var value){
    if (value is String){
      return value.isNotEmpty;
    } else {
      return value != null;
    }
  }

  ///To validate the quantity is in certain range. 
  bool quantityValidation(int quantity, {int minimum = 0, int maximum = 20}){
    if ((minimum < maximum) && (minimum >= 0)){
      return ((quantity >= minimum) && (quantity <= maximum));
    } 
    return false;
  }
  ///To validate the price given is greater than certain value
  bool priceValidation(double price, {int minimum = 0}){
    if (minimum >= 0){
      return price > minimum;
    }
    return false;
  }

  ///To validate date input match the yyyy-mm-dd format. E.g. 2022-01-01
  bool dateValidation(String val){
    return RegExp(r"^[0-2][0-9][0-9][0-9]-[0-1][0-9]-[0-4][0-9]").hasMatch(val);
  }

}