import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/app_regex.dart';

void main() {
  group('password validation -', () {
    test(
      'give a password when isPassword vaild function called then reture true ',
      () {
        // Arrange : define password
        final String vaildPassword = 'Bahnas11@113';

        // Act
        final result = AppRegex.isPasswordValid(vaildPassword);
        // Assertion
        expect(result, true);
      },
    );
    test(
      'give a password when isPassword vaild function called then reture false ',
      () {
        // Arrange : define password
        final String vaildPassword = 'Bahnas113';

        // Act
        final result = AppRegex.isPasswordValid(vaildPassword);
        // Assertion
        expect(result, false);
      },
    );
    test(
      'give a password when isPassword vaild function called then reture false ',
      () {
        // Arrange : define password
        final String vaildPassword = 'Bahnas@113';

        // Act
        final hasLowerCase = AppRegex.hasLowerCase(vaildPassword);
        final hasMinLength = AppRegex.hasMinLength(vaildPassword);
        final hasNumber = AppRegex.hasNumber(vaildPassword);
        final hasSpecialCharacter = AppRegex.hasSpecialCharacter(vaildPassword);
        final hasUpperCase = AppRegex.hasUpperCase(vaildPassword);
        // Assertion
        expect(hasLowerCase, true);
        expect(hasMinLength, true);
        expect(hasNumber, true);
        expect(hasSpecialCharacter, true);
        expect(hasUpperCase, true);
      },
    );
  });

  group('Email Validation', () {
    test(
      'give a email when isEmailvaild function called then reture true ',
      () {
        // Arrange : define password
        final String vaildEmail = 'Bahnas555@gmail.com';

        // Act
        final result = AppRegex.isEmailValid(vaildEmail);
        // Assertion
        expect(result, true);
      },
    );
    test(
      'give a email when isEmailvaild function called then reture false ',
      () {
        // Arrange : define password
        final String vaildEmail = 'Bahnas@gmail.';

        // Act
        final result = AppRegex.isEmailValid(vaildEmail);
        // Assertion
        expect(result, false);
      },
    );
  });
}
