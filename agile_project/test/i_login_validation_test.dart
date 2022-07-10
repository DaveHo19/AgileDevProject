import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/utilities/field_validation.dart';

void main() {
  FieldValidation field_validation = FieldValidation();

  test('email and password is correct', () {
    var email = "aiweitan@gmail.com";
    var password = "2ashb89zk";

    expect(field_validation.validateEmailPassword(email, password), true);
  });
}
