import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/utilities/field_validation.dart';

void main() {
  FieldValidation field_validation = FieldValidation();

  test('email and password is correct', () {
    String email = "aiweitan@gmail.com";
    String password = "2aB90ak#ab";

    expect(field_validation.validateEmailPassword(email, password), true);
  });
}
