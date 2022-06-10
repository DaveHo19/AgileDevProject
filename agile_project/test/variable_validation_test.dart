import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/utilities/field_validation.dart';

//Class for test the validation function for variable input 
void main(){
  FieldValidation field_validation = FieldValidation();

  test("To check a String variable with 'abc' value; The expected result is true", (){
    String value = "abc";
    expect(field_validation.valueValidation(value), true);
  });
  test("To check a String variable with '' value; The expected result is false", (){
    String value = "";
    expect(field_validation.valueValidation(value), false);
  });
  test("To check a int variable with null value; The expected result is false", (){
  int? value;
  expect(field_validation.valueValidation(value), false);
});
  test("To check a dynamic variable with no assign; The expected result is false", (){
  dynamic value;
  expect(field_validation.valueValidation(value), false);
}); 
}