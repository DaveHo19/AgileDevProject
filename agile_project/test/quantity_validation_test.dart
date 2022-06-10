import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/utilities/field_validation.dart';

//Class for test the validation function for quantity input 
void main(){
  FieldValidation field_validation = FieldValidation();

  test("To check the quantity with 10, and the preset range is 1-20; The expected result is true", (){
    expect(field_validation.quantityValidation(10), true);
  });
  test("To check the quantity with -5, and the preset range is 1-20; The expected result is false", (){
      expect(field_validation.quantityValidation(-5), false);

  });
  test("To check the quantity with 2, and the custom range is 2-5; The expected result is true", (){
      expect(field_validation.quantityValidation(2, minimum: 2, maximum: 5), true);

  });
  test("To check the quantity with 9, and the preset range is -5 ~ 15; The expected result is false", (){
    expect(field_validation.quantityValidation(9, minimum: -5, maximum: 15), false);
  });
  test("To check the quantity with 9, and the preset range is 15 ~ 5; The expected result is false", (){
    expect(field_validation.quantityValidation(9, minimum: 15, maximum: 5), false);
  });
}