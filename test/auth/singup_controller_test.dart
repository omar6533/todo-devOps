// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:mytodo/controllers/auth/signup_controller.dart';

class AuthSingUp extends Mock implements SignUpController {
  AuthSingUp _singUp = AuthSingUp();
  @override
  isValidEmail(email) {
    bool valid = false;
    valid = GetUtils.isEmail(email);

    return valid;
  }

  @override
  isValidPassword(password) {
    bool valid = false;
    if (password.isNotEmpty && password.length >= 8) {
      valid = true;
    }

    return valid;
  }

  @override
  singUp(String email, String password) async {
    var resonpse = _singUp.singUp(email, password);
    print(resonpse);
    var hasValue;

    if (resonpse != null) {
      hasValue = true;
    } else {
      hasValue = false;
    }
    return hasValue;
  }
}

void main() {
  AuthSingUp testSingup = AuthSingUp();
  test(
    'isValid email ',
    () {
      expect(testSingup.isValidEmail('omar@gmail.com'), true);
      expect(testSingup.isValidEmail('omar@gmail.'), false);
    },
  );
  test(
    'isValid password ',
    () {
      expect(testSingup.isValidPassword('12345678'), true);
      expect(testSingup.isValidPassword(''), false);
    },
  );
  test(
    'singUP ',
    () {
      expectLater(testSingup.singUp('omar11@gmail.', '12456780'), false);
    },
  );
}
