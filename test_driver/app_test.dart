import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

//To run integration tests: "flutter drive --target=test_driver/app.dart"

void main() {
  group(
    'Authentication',
    () {
      final emailTf = find.byValueKey('email-tf');
      final pswdTf = find.byValueKey('pswd-tf');
      final signInBtn = find.byValueKey('sign-in-btn');

      final fourthSpot = find.byValueKey('spot-3');

      late FlutterDriver driver;

      setUpAll(() async {
        driver = await FlutterDriver.connect();
        await driver.waitUntilFirstFrameRasterized();
      });

      test(
        'Sign in and open a spot screen',
        () async {
          await driver.tap(emailTf);
          await driver.enterText('ggutiflo@gmail.com');
          await driver.tap(pswdTf);
          await driver.enterText('123456');
          await driver.tap(signInBtn);
          await driver.tap(fourthSpot);
        },
      );

      tearDownAll(
        () async {
          await driver.close();
        },
      );
    },
  );
}
