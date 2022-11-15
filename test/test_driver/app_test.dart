import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test/integration_test_driver.dart';
import 'package:mytodo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'Auth test',
    () {
      testWidgets(
        'loign test',
        (tester) async {
          app.main();
          await tester.pumpAndSettle();
          final emailField = find.byKey(ValueKey('email'));
          final passwordField = find.byKey(ValueKey('password'));
          final loginButton = find.byKey(ValueKey('login'));

          //
          await tester.enterText(emailField, 'omar@gmail.com');
          await tester.enterText(passwordField, '12345678');
          await tester.pumpAndSettle();

          await tester.tap(loginButton);
          await tester.pumpAndSettle();
        },
      );
    },
  );
}
