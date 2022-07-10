import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/utilities/field_validation.dart';

//Class for test the validation function for username input
void main() {
  FieldValidation field_validation = FieldValidation();

  test(
      "To check name validation return true values based on name string as input is '_csinni' and expected result is 'false' ",
      () {
    expect(field_validation.validateName("_csinni"), false);
  });

  test(
      "To check name validation return true values based on name string as input is '.csinni' and expected result is 'false' ",
      () {
    expect(field_validation.validateName(".csinni"), false);
  });

  test(
      "To check name validation return true values based on name string as input is 'Csn' and expected result is 'false' ",
      () {
    expect(field_validation.validateName("Csn"), false);
  });

  test(
      "To check name validation return true values based on name string as input is 'CSN1' and expected result is 'false' ",
      () {
    expect(field_validation.validateName("CSN1"), false);
  });

  test(
      "To check name validation return true values based on name string as input is 'csinni_' and expected result is 'false' ",
      () {
    expect(field_validation.validateName("csinni_"), false);
  });

  test(
      "To check name validation return true values based on name string as input is 'csinni.' and expected result is 'false' ",
      () {
    expect(field_validation.validateName("csinni."), false);
  });
}
