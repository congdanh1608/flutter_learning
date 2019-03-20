import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Counter function', () {
    final counterTextFinder = find.byValueKey('counter');
    final btnFinder = find.byValueKey('increment');

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('start at 0', () async {
      expect(await driver.getText(counterTextFinder), '0');
    });

    test('increments the counter', () async {
      await driver.tap(btnFinder);

      expect(await driver.getText(counterTextFinder), '1');
    });
  });
}
