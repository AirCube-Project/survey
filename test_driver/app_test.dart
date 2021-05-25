// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Welcome Test', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    // final counterTextFinder = find.byValueKey('counter');
    // final buttonFinder = find.byValueKey('increment');
    // final welcomeTitle = find.text("Здравствуйте!");
    final welcomeTitle = find.byValueKey("welcome_title");
    final femaleGender = find.byValueKey("female_gender");
    final maleGender = find.byValueKey("male_gender");
    final age = find.byValueKey("age");

    // final welcomeTitle2 = find.bySemanticsLabel("welcome_title");

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test("check welcome page", () async {
      expect(await driver.getText(welcomeTitle), contains("Здравствуйте"));
      driver.waitFor(femaleGender);
      print(femaleGender);
      driver.tap(femaleGender);
      driver.waitUntilFirstFrameRasterized();
      // await
      //проверка, что переход запрещен (пока не заполнены данные)
      var welcomeNext = find.byValueKey("welcome_next");
      driver.tap(welcomeNext, timeout: Duration(milliseconds: 500));
      // expect(await driver.getText(welcomeTitle, timeout: Duration(seconds: 1)), contains("Здравствуйте"));
      // driver.tap(age);
      // driver.enterText("40");
      // driver.tap(welcomeNext);
      // expect(await driver.getText(welcomeTitle), contains("Здравствуйте"));

    });

    // test('starts at 0', () async {
    //   Use the `driver.getText` method to verify the counter starts at 0.
      // expect(await driver.getText(counterTextFinder), "0");
    // });
    //
    // test('increments the counter', () async {
    //   First, tap the button.
      // await driver.tap(buttonFinder);
      //
      // Then, verify the counter text is incremented by 1.
      // expect(await driver.getText(counterTextFinder), "1");
    // });
  });
}