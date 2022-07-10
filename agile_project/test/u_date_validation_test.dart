import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/utilities/field_validation.dart';

//Class for test the validation function for date input 
void main(){
  FieldValidation field_validation = FieldValidation();

  test("To check date validation return true value based on date string as input is '15-22-2022' and expected result is 'false'", (){
    expect(field_validation.dateValidation("15-22-2022"), false);
  });
  test("To check date validation return true value based on date string as input is '15-12-2022' and expected result is 'false'", (){
    expect(field_validation.dateValidation("15-12-2022"), false);
  });
  test("To check date validation return true value based on date string as input is '2022-01-1' and expected result is 'false'", (){
    expect(field_validation.dateValidation("2022-01-1"), false);
  });
  test("To check date validation return true value based on date string as input is '2022-01-22' and expected result is 'false'", (){
    expect(field_validation.dateValidation("22-01-22"), false);
  });
}