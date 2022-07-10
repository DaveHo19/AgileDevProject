import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/utilities/field_validation.dart';

void main() {
  FieldValidation field_validation = FieldValidation();

  test(
      "To check contact number validation return true values based on contact number string as input is '+601134567890' and expected result is 'false' ",
      () {
    expect(field_validation.validatePhone("+601134567890"), false);
  });

  test(
      "To check contact number validation return true values based on contact number string as input is '+6011-34567890' and expected result is 'false' ",
      () {
    expect(field_validation.validatePhone("+6011-34567890"), false);
  });

  test(
      "To check contact number validation return true values based on contact number string as input is '011345678901' and expected result is 'false' ",
      () {
    expect(field_validation.validatePhone("011345678901"), false);
  });

  test(
      "To check contact number validation return true values based on contact number string as input is '011345678' and expected result is 'false' ",
      () {
    expect(field_validation.validatePhone("011345678"), false);
  });

  test(
      "To check contact number validation return true values based on contact number string as input is '011 34567890' and expected result is 'false' ",
      () {
    expect(field_validation.validatePhone("011 34567890"), false);
  });
}
