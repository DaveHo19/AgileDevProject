import 'package:flutter_test/flutter_test.dart';
import 'package:agile_project/utilities/field_validation.dart';

void main() {
  FieldValidation field_validation = FieldValidation();

  test('email returns error value', () {
    var email = "aiweitan@gmail.com";
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    expect(field_validation.validateEmail(email), false);
  });
}
