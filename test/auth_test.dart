// Imports the Flutter Driver API.
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  // IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  enableFlutterDriverExtension();

  group('auth test group ', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final buttonLoginFinder = find.byValueKey('login');
    final emailField = find.byValueKey('email');
    final passwordField = find.byValueKey('password');
    final loginSuccMessage = find.byValueKey('login');
    final loginFailMessage = find.byValueKey('login');

    // final buttonFinder = find.byTooltip('Increment');
    // final buttonAdd = find.byValueKey("add");
    // final buttonSubtract = find.byValueKey("subtract");
    // final alertText = find.byValueKey("alert_text");
    // final btnClose = find.byValueKey("close_button");

    late FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect(
          dartVmServiceUrl: 'ws://127.0.0.1:52186/E2qgpUWMy4A=/ws');
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    test('login button', () async {
      // First, tap on the button
      await driver.tap(emailField);
      await driver.clearTimeline(timeout: Duration(seconds: 10));

      await driver.enterText('omar@gmail.com');
      await driver.clearTimeline(timeout: Duration(seconds: 10));
      await driver.tap(passwordField);
      await driver.clearTimeline(timeout: Duration(seconds: 10));
      await driver.enterText('1234567');
      await driver.clearTimeline(timeout: Duration(seconds: 10));

      await driver.tap(buttonLoginFinder);

      // Then, verify the counter text has been incremented by 1
      expect(await driver.getText(loginFailMessage), "fail");

      // // First, tap on the button
      // await driver.tap(buttonFinder);

      // // Then, verify the counter text has been incremented by 1
      // expect(await driver.getText(counterTextFinder), "2");
    });

    // test("Test with alert window", () async {
    //   // await driver.tap(buttonAdd);

    //   // expect(await driver.getText(alertText), "Welcome to ExecuteAutomation 2");

    //   // // Tap the close link to close the alert box
    //   // await driver.tap(btnClose);

    //   // //Click subtract again
    //   // await driver.tap(buttonSubtract);

    //   // //Verify if its correct
    //   // expect(await driver.getText(counterTextFinder), "1");
    // });
  });
}
