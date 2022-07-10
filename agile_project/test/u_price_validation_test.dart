import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/utilities/field_validation.dart';

//Class for test the validation function for price input 
void main(){
  FieldValidation field_validation = FieldValidation();

  test("To check the price with 10, and the minimum value is 0; The expected result is true", (){
    expect(field_validation.priceValidation(10), true);
  });
  test("To check the price with -5, and the minimum value is 0; The expected result is false", (){
    expect(field_validation.priceValidation(-5), false);
  });
  test("To check the price with 0.1, and the minimum value is 0; The expected result is true", (){
    expect(field_validation.priceValidation(0.1), true);
  });
  test("To check the price with 5, and the set minimum value is negative; The expected result is false", (){
    expect(field_validation.priceValidation(5, minimum: -5), false);
  });
}