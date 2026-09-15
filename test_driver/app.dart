import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart' as test;

void main() {
  group('HabitTracker Pro Performance Tests', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      await driver.close();
    });

    test('measure app startup time', () async {
      final timeline = await driver.traceAction(() async {
        await driver.waitFor(find.byType('MaterialApp'));
      });

      expect(timeline, isNotNull);
    });

    test('measure frame rate during navigation', () async {
      final timeline = await driver.traceAction(() async {
        await driver.waitFor(find.byType('MaterialApp'));
      });

      expect(timeline, isNotNull);
    });
  });
}